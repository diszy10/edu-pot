import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:edukasi_pot/mocks/admin.dart';

class AdminAuthNotifier with ChangeNotifier {
  String _prefsKey = 'adminToken';

  String _token;

  Future<String> get token async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(_prefsKey);
    return _token;
  }

  Future<bool> get isAdminAuth async {
    // Simulate auth delay.
    final _tok = await token;
    return _tok != null && _tok != '' ? true : false;
  }

  Future<String> _authenticate(String email, String password) async {
    for (var admin in admins) {
      if (admin['email'] == email && admin['password'] == password) {
        return admin['token'];
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
