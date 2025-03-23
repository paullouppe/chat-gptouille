import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/screens/pages_navbar.dart';
import 'package:flutter_app/screens/signin/provider_user.dart';
import 'package:flutter_app/screens/signup/sign_up.dart';
import 'package:flutter_app/screens/widgets/alert_dialog.dart';
import 'package:flutter_app/screens/widgets/button.dart';
import 'package:flutter_app/services/requests.dart';
import 'package:provider/provider.dart';

import '../widgets/login_bar.dart';

// Login page
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // Controllers to manage login info
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Function to manage the "login" button.
  void pressLogin(BuildContext context) async {
    // First, get email and password info
    String mail = mailController.text;
    String password = passwordController.text;
    // Then call API
    Map<String, dynamic> userData = {
      "mail": mail,
      "password": password,
    };
    String apiUrl = "http://localhost:8080/users/login";
    // If API response is correct, log in ang go to the main page.
    String response = await postRequest(userData, apiUrl);

    if (response != "problem" && response != "Invalid email or password") {
      // Transforming the script back to json.
      Map<String, dynamic> userLoggedData = jsonDecode(response);
      // And instanciacing a provider to manage login information on all pages of the app.
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUser(userLoggedData['access_token'],
          userLoggedData["name"], userLoggedData["id"]);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavBarPages()),
      );
    }
    // Error message if password is incorrect
    else if (response == "Invalid email or password") {
      _showTryAgainLogin(context);
    }
    // If an issue arises, ask to try again later.
    else {
      AlertDialogProblem();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          // Avoid errors due to screen size.
          child: Column(
        children: [
          Image.asset(
            'assets/images/deco_login_signup.png',
            width: double.infinity, // extends image.
            fit: BoxFit.cover, // covers the entire screen
          ),
          Column(children: [
            // Page main text
            Text(
              'Login here',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Color(0xFFFE724C),
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: 200,
              child: Text(
                "Welcome back, you've been missed!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ]),
          SizedBox(height: 50),
          // Login text fields
          Column(children: [
            EmailInputWidget(
              controllerMail: mailController,
              controllerPassw: passwordController,
            ),
            SizedBox(height: 50),
            ButtonGeneric(
              content: "LOGIN",
              pressedFunction: () {
                pressLogin(context);
              },
            ),
            SizedBox(height: 40),
            //TextButton to move to sign up page.
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text(
                "Don't have an account? Sign up",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFFFE724C),
                ),
              ),
            ),
          ]),
        ],
      )),
    );
  }
}

void _showTryAgainLogin(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Invalid mail or password."),
        content: Text("Try again to find your password or email."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Closes error pop up.
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}
