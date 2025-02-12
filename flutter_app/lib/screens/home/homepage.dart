import 'package:flutter/material.dart';


//Classe qui donne le contenu de la Homepage sans prendre en considératiion le navigation bar qui est traité à part. 
//(c'est là où on construit la page, pas au dessus)
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Welcome to the Home Page!',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}