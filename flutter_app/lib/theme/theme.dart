import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Color(0xFFFE724C),
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF323643),
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Color(0xFF323643),
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xFF7E8392),
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Color(0xFFFE724C),
      secondary: Color(0xFF353545),
      tertiary: Color(0xFFF5F5F6),
      onSurface: Color(0xFFFFBBA9),
      inversePrimary: Color(0xFFBBB8C2),
      surface: Color(0xFFFFFFFF),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Color(0xFFFE724C),
    scaffoldBackgroundColor: Color(0xFF2A293A),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFEFEFE),
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Color(0xFFFEFEFE),
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xFFe5e5e5),
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: Color(0xFFFE724C),
      secondary: Color(0xFFFCFCFD),
      tertiary: Color(0xFF393948),
      onSurface: Color(0xFFFFBBA9),
      inversePrimary: Color(0xFF8A8A96),
      surface: Color(0xFF393948),
    ),
  );
}
