import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int selectedIndex; // Selected item index.
  final Function(int)
      onItemTapped; // Function to change color of the tapped item.

  const NavBar(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
      onTap:
          onItemTapped, // Function to change theme depending on button pressed.
      backgroundColor: Theme.of(context).colorScheme.surface,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.inversePrimary,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chatbot"),
        BottomNavigationBarItem(icon: Icon(Icons.add_box), label: "Add recipe"),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined), label: "Profile"),
      ],
    );
  }
}
