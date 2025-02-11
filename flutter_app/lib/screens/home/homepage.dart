import 'package:flutter/material.dart';
import 'package:flutter_app/screens/chatbot/chatbot_page.dart';
import 'package:flutter_app/screens/recipe_desc/recipe_page.dart';

import '../widgets/navbar.dart';
import '../profile/profile_page.dart';


//A NE PAS MODIFIER, CE N EST PAS ICI QU'ON MET LE CONTENU DE HOMEPAGE (voir fin du code, la classe HomePageContent)
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
    HomePageContent(),
    ChatbotPage(),
    RecipePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

//Classe qui donne le contenu de la Homepage sans prendre en considératiion le navigation bar qui est traité à part. 
//(c'est là où on construit la page, pas au dessus)
class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Welcome to the Home Page!',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}