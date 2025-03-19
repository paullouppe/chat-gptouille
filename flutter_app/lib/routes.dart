import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/homepage.dart';
import 'package:flutter_app/screens/profile/profile_page.dart';
import 'package:flutter_app/screens/signin/login_page.dart';

class Routes {
  static const String home = '/';
  static const String login = '/login';
  static const String settings = '/settings';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => HomePage(),
      login: (context) => LoginPage(),
      settings: (context) => ProfilePage(),
    };
  }
}
