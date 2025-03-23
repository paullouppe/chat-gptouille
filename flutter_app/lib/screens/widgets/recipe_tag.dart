import 'package:flutter/material.dart';

// Recipe tags appearing on the bottom of recipe cards.
class RecipeTag extends StatelessWidget {
  final String text;
  final double borderRadius;
  final double fontSize;

  const RecipeTag(
      {super.key,
      required this.text,
      required this.borderRadius,
      required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: fontSize,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
