import 'package:flutter/material.dart';
import 'routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatGPTouille',
      debugShowCheckedModeBanner: false,
      // Set the initial route; here we use the home route defined in routes.dart
      initialRoute: Routes.home,
      // Define the app routes
      routes: Routes.getRoutes(),
    );
  }
}
