import 'package:flutter/material.dart';
import 'package:flutter_app/screens/signup/sign_up.dart';
import 'package:flutter_app/screens/widgets/button.dart';

import '../widgets/login_bar.dart';

//Classe contenant la page de login
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  //Fonction qui indique ce qu'il se passe quand on appuie sur le bouton "login"
  void pressLogin(){

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SingleChildScrollView( //permet d'éviter les erreurs de dimension de l'écran.
            child : Column(
            children: [
              Image.asset(
              'images/deco_login_signup.png',
                width: double.infinity, //ça c'est pour étendre l'image
                fit: BoxFit.cover, //Couvre tout l'écran
              ),
              Column(
                children:[
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
                    child:
                    Text(
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
                ]
              ),
              SizedBox(height: 50),
              //Champs de texte pour la connexion
              Column(
                  children: [
                    EmailInputLogin(),
                    SizedBox(height: 50),
                    ButtonGeneric(content: "LOGIN", pressedFunction: pressLogin),
                    SizedBox(height: 40),
                    //TextButton pour aller sur la page de création de compte
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpPage()),
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
                ]   
              ),
      ],)
      ),
    );
  }
}