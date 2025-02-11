import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

class Routes {
  static const String home = '/';
  static const String login = '/login';
  static const String settings = '/settings';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => Chatgptouille(),
      login: (context) => Chatgptouille(),
      settings: (context) => Chatgptouille(),
    };
  }
}
