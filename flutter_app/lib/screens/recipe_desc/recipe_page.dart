import 'package:flutter/material.dart';


class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  RecipePageState createState() => RecipePageState();
}

class RecipePageState extends State<RecipePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Page de recette"),
    );
  }
}