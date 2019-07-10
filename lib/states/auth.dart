import 'package:flutter/material.dart';

class AuthNotifier with ChangeNotifier {
  bool _isAuthenticated = true;
  bool get isAuthenticated => _isAuthenticated;

  void login() {
    _isAuthenticated = true;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}