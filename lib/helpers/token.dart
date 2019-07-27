import 'package:shared_preferences/shared_preferences.dart';

mixin Token {
  String _prefsKey = 'userToken';

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_prefsKey);
  }

  Future<bool> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(_prefsKey, token);
  }

  Future<bool> delToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(_prefsKey, '');
  }
}