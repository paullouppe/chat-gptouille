import 'package:flutter/material.dart';

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
        color: Color.fromARGB(255, 212, 212, 212),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: const Color.fromARGB(255, 97, 97, 97),
            fontSize: fontSize,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
