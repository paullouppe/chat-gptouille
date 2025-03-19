import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './theme/theme_provider.dart';
import 'screens/pages_navbar.dart';
import 'package:flutter_app/screens/signup/sign_up.dart';


void main() {
  runApp(const Chatgptouille());
}

class Chatgptouille extends StatelessWidget {
  const Chatgptouille({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
    );
  }
}