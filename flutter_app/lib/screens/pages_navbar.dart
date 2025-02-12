import 'package:flutter/material.dart';
import 'package:flutter_app/screens/chatbot/chatbot_page.dart';
import 'package:flutter_app/screens/recipe_desc/recipe_page.dart';

import 'widgets/navbar.dart';
import 'home/homepage.dart';
import 'profile/profile_page.dart';


//A NE PAS MODIFIER
class NavBarPages extends StatefulWidget {
  const NavBarPages({super.key});

  @override
  NavBarPagesState createState() => NavBarPagesState();
}

class NavBarPagesState extends State<NavBarPages> {
  //Indice correspondant à l'item sélectionné dans la navigation bar
  int _selectedIndex = 0;

  //Fonction qui change la couleur des items selon la sélection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //Liste des pages qui sont accessibles via la navigation bar. 
  final List<Widget> _pages = [
    HomePage(),
    ChatbotPage(),
    RecipePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: _selectedIndex==1? null :
      NavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}