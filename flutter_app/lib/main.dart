import 'package:flutter/material.dart';
import 'package:flutter_app/screens/signin/login_page.dart';
import 'package:flutter_app/screens/signin/provider_user.dart';
import 'package:provider/provider.dart';
import './theme/theme_provider.dart';
import 'screens/pages_navbar.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()), // Ajout de UserProvider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.themeData, // Applique le thème dynamique
      home: userProvider.isLoggedIn ? NavBarPages() : LoginPage(), // Page principale
    );
  }
}
