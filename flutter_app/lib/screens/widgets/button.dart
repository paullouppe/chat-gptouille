import 'package:flutter/material.dart';

class ButtonGeneric extends StatelessWidget {
  //fonction qui change la couleur selon l'item sélectionné
  final String content;

  const ButtonGeneric({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Button onPressed action
      },
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
