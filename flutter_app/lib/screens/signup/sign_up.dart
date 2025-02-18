import 'package:flutter/material.dart';
import 'package:flutter_app/screens/signin/login_page.dart';
import 'package:flutter_app/screens/widgets/button.dart';
import 'package:flutter_app/screens/widgets/login_bar.dart';

//Page de création de compte
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  //Fonction qui indique ce qu'il se passe quand on appuie sur le bouton "signup"
  void pressSignup(){

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
                fit: BoxFit.cover, 
              ),
              Column(
                children:[
                  //Texte de présentation de la page
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
                    child:
                    Text(
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
                ]
              ),
              SizedBox(height: 50),
              //Champs de texte nécessaires pour la création de compte
              Column(
                  children: [
                    FullNameWidget(),
                    SizedBox(height: 30),
                    EmailInputLogin(),
                    SizedBox(height: 50),
                    ButtonGeneric(content: "SIGN UP", pressedFunction: pressSignup),
                    SizedBox(height: 40),
                ]   
              ),
              //TextButton pour passer à la page de connexion
              TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
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
      ],)
      ),
    );
  }
}


//Classe contenant le champ de texte pour obtenir le full name
class FullNameWidget extends StatelessWidget {
  const FullNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300, //largeur pour correspondre à la maquette figma
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
        child:TextField(
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
              borderSide: BorderSide(color: Colors.grey.shade300), //couleur de bordure sans qu'on clique dessus
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color(0xFFFE724C)), //bordure orange quand on clique
            ),
          ),
        ),
      ),
      ],
    ),
    );
    }
}