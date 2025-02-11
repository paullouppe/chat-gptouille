import 'package:flutter/material.dart';
import 'package:flutter_app/screens/test_screen.dart';

class Routes {
  static const String home = '/';
  static const String login = '/login';
  static const String settings = '/settings';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const TestScreen(),
      login: (context) => const TestScreen(),
      settings: (context) => const TestScreen(),
    };
  }
}
