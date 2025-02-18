import 'package:flutter/material.dart';

//Classe contenant les champs de texte nécessaires pour le login et le signup (mot de passe et mail)
class EmailInputLogin extends StatelessWidget {
  const EmailInputLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300, //largeur définie pour correspondre à la maquette
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Champ de texte pour le mail
        Text(
          'E-mail',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: Colors.grey[600], 
          ),
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            hintText: 'Your email',
            hintStyle: TextStyle(color: Colors.grey[400]), 
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0), 
              borderSide: BorderSide.none, 
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey.shade300), // Couleur de bordure quand on clique pas dessus
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color(0xFFFE724C)), // Bordure orange quand on clique dessus
            ),
          ),
        ),
        SizedBox(height: 30),
        //Champ de texte pour le password
        Text(
          'Password',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 10),
        PasswordInputLogin()
      ],
    ));
  }
}

//Classe contenant le champ de texte pour le mot de passe
class PasswordInputLogin extends StatefulWidget {
  const PasswordInputLogin({super.key});

  @override
  PasswordInputLoginState createState() => PasswordInputLoginState();
}

//On utilise une classe d'état pour afficher ou non le mot de passe
class PasswordInputLoginState extends State<PasswordInputLogin> {
  bool _showText = true;  //variable qui définit si on montre le mot de passe ou non

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _showText,  
      decoration: InputDecoration(
        hintText: 'Enter your password',
        suffixIcon: IconButton(
          icon: Icon(
            _showText ? Icons.visibility_off : Icons.visibility,  // On change l'icône des yeux ici
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _showText = !_showText;  //Selon que le bouton est pressé, on peut afficher/masquer le mot de passe
            });
          },
        ),
        hintStyle: TextStyle(color: Colors.grey[400]),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), 
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.grey.shade300), 
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Color(0xFFFE724C)), // bordure orange quand on clique dessus
          ),
      ),
    );
  }
}