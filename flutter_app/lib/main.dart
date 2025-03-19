import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './theme/theme_provider.dart';
import 'screens/pages_navbar.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.themeData, // Applique le thème dynamique
      home: const NavBarPages(), // Page principale
    );
  }
}
