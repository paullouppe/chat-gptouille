import 'package:flutter/material.dart';
import 'package:flutter_app/screens/signin/login_page.dart';
import 'package:flutter_app/screens/widgets/alert_dialog.dart';
import 'package:flutter_app/screens/widgets/button.dart';
import 'package:flutter_app/screens/widgets/login_bar.dart';
import 'package:flutter_app/services/requests.dart';

// Sign up page.
class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  //Controllers to manage text data for account creation.
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Function to manage "sign up" button.
  Future<void> pressSignup(BuildContext context) async {
    // First : get name, mail and password info.
    String fullName = fullNameController.text;
    String mail = mailController.text;
    String password = passwordController.text;
    // Then call API
    Map<String, dynamic> userData = {
      "mail": mail,
      "name": fullName,
      "password": password,
    };
    String apiUrl = "http://localhost:8080/users/signup";
    // If API response is correct, show success pop up.
    String response = await postRequest(userData, apiUrl);
    if (response != "problem" && response != "mail already exists") {
      _showSuccessSignUp(context);
    }
    //If email aready exists, asks to try again with another.
    else if (response == "mail already exists") {
      _showTryAgainSignUp(context);
    }
    // If other issue arises, asks to try again later.
    else {
      AlertDialogProblem();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          // avoids error from screen size
          child: Column(
        children: [
          Image.asset(
            'images/deco_login_signup.png',
            width: double.infinity, // covers the entire screen
            fit: BoxFit.cover,
          ),
          Column(children: [
            // Main title
            Text(
              'Account creation',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Color(0xFFFE724C),
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: 300,
              child: Text(
                "Create an account so you can explore delicious recipes!",
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
          // Text fields to create account.
          Column(children: [
            FullNameWidget(controller: fullNameController),
            SizedBox(height: 30),
            EmailInputWidget(
              controllerMail: mailController,
              controllerPassw: passwordController,
            ),
            SizedBox(height: 50),
            ButtonGeneric(
              content: "SIGN UP",
              pressedFunction: () {
                pressSignup(context);
              },
            ),
            SizedBox(height: 40),
          ]),
          //TextButton to go to login page.
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text(
              "Already have an account? Login",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFFFE724C),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class FullNameWidget extends StatefulWidget {
  final TextEditingController controller; // Get value

  const FullNameWidget({super.key, required this.controller});

  @override
  State<FullNameWidget> createState() => _FullNameWidgetState();
}

// Gets full name.
class _FullNameWidgetState extends State<FullNameWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300, // same width as Figma model.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Full Name',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: 300,
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                hintText: 'Full Name',
                hintStyle: TextStyle(color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      color: Colors.grey
                          .shade300), // Default color before being clicked.
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      color: Color(0xFFFE724C)), // Orange border once clicked.
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showSuccessSignUp(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Account created"),
        content: Text(
            "Your account was created! You need to connect to confirm your identity."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Closes pop up
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              ); // Go to login page
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}

void _showTryAgainSignUp(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Mail already exists"),
        content: Text(
            "This mail is already used for another profile. Consider using another email, or connect with your current email."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Closes pop up
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}
