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

  // Mettre à jour les données de l'utilisateur
  void setUser(String token, String name, int id) {
    _accessToken = token;
    _name = name;
    _id = id;
    _isLoggedIn = true;
    notifyListeners();
  }

  bool isTokenExpired() {
    if (_accessToken.isEmpty) {
      return true; // Si le token est vide, considérer qu'il est expiré
    }

    // Utilisation de jwt_decoder pour vérifier si le token est expiré
    return JwtDecoder.isExpired(_accessToken);
  }

  // Déconnecter l'utilisateur
  void logout() {
    _accessToken = '';
    _name = '';
    _id=-1;
    _isLoggedIn = false;
    notifyListeners();
  }
}