import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthNotifier with ChangeNotifier {
  String _prefsKey = 'auth';

  bool _isAuth = false;

  Future<bool> get isAuth async {
    final prefs = await SharedPreferences.getInstance();
    _isAuth = prefs.getBool(_prefsKey) ?? false;
    return _isAuth;
  }

  Future<bool> login() async {
    // Simulate login delay.
    await Future<bool>.delayed(Duration(milliseconds: 600));

    final _isAuth = true;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_prefsKey, _isAuth);
    notifyListeners();

    return _isAuth;
  }

  Future<bool> logout() async {
    final _isAuth = false;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_prefsKey, _isAuth);
    notifyListeners();

    return true;
  }
}