import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int selectedIndex; //index de l'item sélectionné
  final Function(int)
      onItemTapped; //fonction qui change la couleur selon l'item sélectionné

  const NavBar(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
      onTap:
          onItemTapped, //fonction qui va changer la couleur selon l'item tappé
      backgroundColor: Theme.of(context).colorScheme.surface,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.inversePrimary,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chatbot"),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite), label: "Your recipes"),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined), label: "Profile"),
      ],
    );
  }
}
