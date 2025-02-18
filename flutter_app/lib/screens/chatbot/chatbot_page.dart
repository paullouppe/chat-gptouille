import 'package:flutter/material.dart';
import 'package:flutter_app/screens/pages_navbar.dart';


//Classe contenant la page du Chatbot
class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Stack(
        children: [
          //Bouton retour en haut à gauche
          Positioned(
            top: 20.0,
            left: 20.0,
            child: ButtonReturn()
          ),
          //Description du chabot + image dans une colonne en dessous
          Positioned(
          top: 100.0, 
          right: 0,
          left:0,
          child: Align(
            alignment: Alignment.topCenter, 
            child: Column(
                children: [
                  //Image du chatbot
                  Image.asset(
                  'images/chatbot.png',
                    width: 200, 
                    height: 200,
                  ),
                  //Description du chatbot
                  Text( "Hello!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        ),
                  ),
                  Text( "What can I do for you?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(width: 270,
                  child: 
                    Text( "Don't hesitate to ask for any suggestions, I would be glad to answer!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF67666D),
                        ),
                    ),
                  ),
                  
                ],
              ),
            ), 
          ),
          //Bloc contenant la zone d'envoi du message
          Positioned(
            //Zone en bas de page
            bottom: 30.0, 
            left: 20.0,
            right: 20.0,
            child: Row(
            children: [
              //Le champ du message
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, 
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      //Rajout d'une ombre
                      BoxShadow(
                        color: Colors.black12, 
                        offset: Offset(0, 2), 
                        blurRadius: 5.0, //rajoute du flou
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Send your message to Chatgptouille...',
                      border: InputBorder.none, 
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              //Bouton d'envoi
              Container(
                width: 50, 
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFFE724C), 
                  borderRadius: BorderRadius.circular(15.0)
                ),
                child: IconButton(
                  onPressed: () {
                    //ACTION BOUTON D ENVOI
                  },
                  icon: Icon(Icons.send, color: Colors.white),
                ),
              ),
            ],
          ),
          ),     
        ],
      )   
    );
  }
}

//Classe contenant le bouton de retour
class ButtonReturn extends StatelessWidget {
  const ButtonReturn({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      //Retour à la page Home si bouton pressé
      onPressed: (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NavBarPages()),
      );},
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFFFF1EC), 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), 
        ),
        shadowColor: Colors.transparent, //on n'utilise pas l'ombre par défaut, on la customise
        padding: EdgeInsets.all(0), 
      ),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFFFFF1EC), 
          borderRadius: BorderRadius.circular(15),
          //Customisation de l'ombre
          boxShadow: [
            BoxShadow(
              color: Colors.black12, // Ombre foncée en bas à droite
              offset: Offset(3, 3),
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back,
            color: Color(0xFFFE724C), // Orange du bouton
            size: 24,
          ),
        ),
      ),
    );
  }
}