import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserProvider with ChangeNotifier {
  String _accessToken = '';
  String _name = '';
  int _id = -1;
  bool _isLoggedIn = false;

  String get accessToken => _accessToken;
  String get name => _name;
  int get id => _id;
  bool get isLoggedIn => _isLoggedIn;

  // Updates user data.
  void setUser(String token, String name, int id) {
    _accessToken = token;
    _name = name;
    _id = id;
    _isLoggedIn = true;
    notifyListeners();
  }

  bool isTokenExpired() {
    if (_accessToken.isEmpty) {
      return true; // If token is empty, treats it as expired.
    }

    // Use of jwt_decoder to check for token expiration.
    return JwtDecoder.isExpired(_accessToken);
  }

  // Logs out user.
  void logout() {
    _accessToken = '';
    _name = '';
    _id = -1;
    _isLoggedIn = false;
    notifyListeners();
  }
}
