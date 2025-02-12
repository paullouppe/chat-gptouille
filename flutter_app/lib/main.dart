import 'package:flutter/material.dart';
import 'screens/pages_navbar.dart';

void main() {
  runApp(const Chatgptouille());
}


class Chatgptouille extends StatelessWidget {
  const Chatgptouille({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavBarPages(),
    );
  }
}