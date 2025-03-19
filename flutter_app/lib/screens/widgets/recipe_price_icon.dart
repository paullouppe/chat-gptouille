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
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface, // Background color
        shape: BoxShape.circle, // Circular background
      ),
      padding: EdgeInsets.all(1.0), // Adjust padding as needed
      child: Icon(
        Icons.euro,
        size: iconSize,
        color: Theme.of(context).colorScheme.tertiary, // Icon color
      ),
    );
  }
}
