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
<<<<<<< HEAD
        ChangeNotifierProvider(
            create: (context) => UserProvider()), // Ajout de UserProvider
=======
        ChangeNotifierProvider(create: (context) => UserProvider()),
>>>>>>> 5e075e8e34ded340e185d3e7fca4bbb7d0403c66
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
<<<<<<< HEAD
      theme: themeProvider.themeData, // Applique le thème dynamique
      home: userProvider.isLoggedIn
          ? NavBarPages()
          : LoginPage(), // Page principale
=======
      theme: themeProvider.themeData, // Apply dynamic theme.
      home:
          userProvider.isLoggedIn ? NavBarPages() : LoginPage(), // First page.
>>>>>>> 5e075e8e34ded340e185d3e7fca4bbb7d0403c66
    );
  }
}
