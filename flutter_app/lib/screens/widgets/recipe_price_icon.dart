import 'package:flutter/material.dart';

class PriceIcon extends StatelessWidget {
  final bool isFilled;
  final double iconSize;

  const PriceIcon({super.key, required this.isFilled, required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isFilled
            ? Color(0xFFFE724C)
            : Color.fromARGB(255, 255, 187, 168), // Background color
        shape: BoxShape.circle, // Circular background
      ),
      padding: EdgeInsets.all(1.0), // Adjust padding as needed
      child: Icon(
        Icons.euro,
        size: iconSize,
        color: Colors.white, // Icon color
      ),
    );
  }
}
