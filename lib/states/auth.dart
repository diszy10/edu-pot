import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
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