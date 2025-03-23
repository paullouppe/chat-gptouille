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

//Classe contenant la page de login
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //Controllers contenant les infos pour la connexion
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //Fonction qui indique ce qu'il se passe quand on appuie sur le bouton "login"
  void pressLogin(BuildContext context) async {
    //1ère étape = récupérer les infos de mail et de password
    String mail = mailController.text;
    String password = passwordController.text;
    //puis donner à l'API
    Map<String, dynamic> userData = {
      "mail": mail,
      "password": password,
    };
    String apiUrl = "http://localhost:8080/users/login";
    //si la réponse est bonne de l'API, on connecte et on passe à la page principale
    String response = await postRequest(userData, apiUrl);

    if (response != "problem" && response != "Invalid email or password") {
      //On retransforme le string en json
      Map<String, dynamic> userLoggedData = jsonDecode(response);
      //Et on instancie un provider pour utiliser les informations dans toutes les pages
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUser(userLoggedData['access_token'],
          userLoggedData["name"], userLoggedData["id"]);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavBarPages()),
      );
    }
    //Si le mot de passe est incorrect, message d'alerte
    else if (response == "Invalid email or password") {
      _showTryAgainLogin(context);
    }
    //s'il y a un problème, on demande de réessayer plus tard.
    else {
      AlertDialogProblem();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          //permet d'éviter les erreurs de dimension de l'écran.
          child: Column(
        children: [
          Image.asset(
            'assets/images/deco_login_signup.png',
            width: double.infinity, //ça c'est pour étendre l'image
            fit: BoxFit.cover, //Couvre tout l'écran
          ),
          Column(children: [
            //Texte de présentation de la page
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
          //Champs de texte pour la connexion
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
            //TextButton pour aller sur la page de création de compte
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
              Navigator.of(context).pop(); // Fermer l'alerte
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}
