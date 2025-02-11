import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/homepage.dart';


void main() {
  runApp(const Chatgptouille());
}


class Chatgptouille extends StatelessWidget {
  const Chatgptouille({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}