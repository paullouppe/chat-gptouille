import 'package:flutter/material.dart';
import 'package:flutter_app/screens/chatbot/chatbot_page.dart';
import 'package:flutter_app/screens/AddRecipe/recipe_page.dart';
import 'package:flutter_app/screens/signin/login_page.dart';
import 'package:flutter_app/screens/signin/provider_user.dart';
import 'package:provider/provider.dart';

import 'widgets/navbar.dart';
import 'home/homepage.dart';
import 'profile/profile_page.dart';

class NavBarPages extends StatefulWidget {
  const NavBarPages({super.key});

  @override
  NavBarPagesState createState() => NavBarPagesState();
}

class NavBarPagesState extends State<NavBarPages> {
  // Index of the selected item in the navbar
  int _selectedIndex = 0;

  // Changes colors of selected item.
  void _onItemTapped(int index) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // Check for user access token: if expired, deny access.
    if (userProvider.isTokenExpired()) {
      // Removes all user info.
      userProvider.logout();

      // Return the user to login page.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      setState(() {
        // Else if token is valid, allow access.
        _selectedIndex = index;
      });
    }
  }

  // List of pages accessibles from the navbar.
  final List<Widget> _pages = [
    HomePage(),
    ChatbotPage(),
    AddRecipePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: _selectedIndex == 1
          ? null
          : NavBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
    );
  }
}
