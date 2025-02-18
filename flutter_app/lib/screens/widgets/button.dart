import 'package:flutter/material.dart';

class ButtonGeneric extends StatelessWidget {
  
  final String content;
  //Fonction qui est utilisé quand le bouton est cliqué
  final VoidCallback pressedFunction; 

  const ButtonGeneric({super.key, required this.content, required this.pressedFunction });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: pressedFunction,
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(Color((0xFFFE724C))),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ))),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color((0xFFF6F6F6)),
        ),
      ),
    );
  }
}
