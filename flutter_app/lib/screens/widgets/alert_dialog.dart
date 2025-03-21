import 'package:flutter/material.dart';

class AlertDialogProblem extends StatelessWidget{
  const AlertDialogProblem({super.key});

  @override
  Widget build(BuildContext context){
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
  } 
}

