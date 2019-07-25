import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:edukasi_pot/mocks/user.dart';

class AuthNotifier with ChangeNotifier {
  String _prefsKey = 'userToken';

  String _token;

  Future<String> get token async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(_prefsKey);
    return _token;
  }

  Future<bool> get isUserAuth async {
    // Simulate auth delay.
    final _tok = await token;
    return _tok != null && _tok != '' ? true : false;
  }

  Future<String> _authenticate(String email, String password) async {
    for (var user in users) {
      if (user['email'] == email && user['password'] == password) {
        return user['token'];
      }
    }
    return '';
  }

  void _autoLogout() {
    // TODO: Implement auto logout
  }

  Future<bool> login(String email, String password) async {
    _token = await _authenticate(email, password);
    var _isAuth = false;
    if (_token != '') {
      _isAuth = true;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(_prefsKey, _token);
      notifyListeners();
    }

    return _isAuth;
  }

  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_prefsKey, '');
    notifyListeners();
    return true;
  }
}
