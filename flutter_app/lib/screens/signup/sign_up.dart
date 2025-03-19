import 'package:flutter/material.dart';
import 'package:flutter_app/screens/signin/login_page.dart';
import 'package:flutter_app/screens/widgets/button.dart';
import 'package:flutter_app/screens/widgets/login_bar.dart';
import 'package:flutter_app/services/requests.dart';

//Page de création de compte
class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //Fonction qui indique ce qu'il se passe quand on appuie sur le bouton "signup"
  Future<void> pressSignup(BuildContext context) async {
    //1ère étape = récupérer les infos du full name, de mail et de password
    String fullName = fullNameController.text;
    String mail = mailController.text; 
    String password = passwordController.text;
    //puis donner à l'API 
    Map<String, dynamic> userData = {
    "mail": mail,
    "name": fullName,
    "password":password,
    };
    String apiUrl = "http://localhost:8080/users/signup"; 
    //si la réponse est bonne de l'API, on met un petit alert
    String response=await postRequest(userData, apiUrl);
    if (response!="problem" && response!="mail already exists"){
      _showSuccessSignUp(context);
    }
    //Si le mail existe déjà, on demande de réessayer avec un autre mail
    else if (response=="mail already exists"){
      _showTryAgainSignUp(context);
    }
    //s"il y a un problème, on demande de réessayer plus tard.
    else{
      _showProblemSignUp(context);
    }
    
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
                    FullNameWidget(controller: fullNameController),
                    SizedBox(height: 30),
                    EmailInputWidget(controllerMail: mailController, controllerPassw: passwordController,),
                    SizedBox(height: 50),
                    ButtonGeneric(content: "SIGN UP", pressedFunction: () {pressSignup(context);},),
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

class FullNameWidget extends StatefulWidget {
  final TextEditingController controller; // Permet de récupérer la valeur

  const FullNameWidget({super.key, required this.controller});

  @override
  State<FullNameWidget> createState() => _FullNameWidgetState();
}


//Classe contenant le champ de texte pour obtenir le full name
class _FullNameWidgetState extends State<FullNameWidget> {
  
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


void _showSuccessSignUp(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Account created"),
        content: Text("Your account was created! You need to connect to confirm your identity."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fermer l'alerte
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              ); // Aller vers la page de connexion
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
        content: Text("This mail is already used for another profile. Consider using another email, or connect with your current email."),
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


void _showProblemSignUp(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Current problem"),
        content: Text("Our application has currently a problem. Please try to sign up after a few hours."),
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