import 'package:flutter/material.dart';

// Price icon used on recipe cards.
class PriceIcon extends StatelessWidget {
  final bool isFilled;
  final double iconSize;

  const PriceIcon({
    super.key,
    required this.isFilled,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final filledBackground = Theme.of(context).primaryColor;
    final emptyBackground = Theme.of(context).colorScheme.onSurface;
    final filledIcon = Colors.white;
    final emptyIcon = Theme.of(context).primaryColor;

    return Container(
      decoration: BoxDecoration(
        color: isFilled ? filledBackground : emptyBackground,
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(4.0),
      child: Icon(
        Icons.euro,
        size: iconSize,
        color: isFilled ? filledIcon : emptyIcon,
      ),
    );
  }
}
