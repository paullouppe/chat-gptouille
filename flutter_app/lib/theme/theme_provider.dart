import 'package:flutter/material.dart';
import 'theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = AppThemes.lightTheme;

  ThemeData get themeData => _themeData;

  void setLightTheme() {
    _themeData = AppThemes.lightTheme;
    notifyListeners(); // Refresh interface.
  }

  void setDarkTheme() {
    _themeData = AppThemes.darkTheme;
    notifyListeners();
  }
}
