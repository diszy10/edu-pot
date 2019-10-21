import 'dart:convert';

import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService _instance;
  static SharedPreferences _preferences;

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  // Prefs User
  static const String UserKey = 'user';
  User get user {
    var userJson = _getFromDisk(UserKey);
    if (userJson == null) {
      return null;
    }

    return User.fromJson(json.decode(userJson));
  }
  set user(User userToSave) {
    saveStringToDisk(UserKey, json.encode(userToSave.toJson()));
  }
  void removeUser() {
    _preferences.remove(UserKey);
  }

  // Prefs Email
  static const String EmailKey = 'email';
  String get email => _getFromDisk(EmailKey) ?? null;
  set email(String email) {
    saveStringToDisk(EmailKey, email);
  }
  void removeEmail() {
    _preferences.remove(EmailKey);
  }

  String _getFromDisk(String key) {
    var value = _preferences.get(key);
    // print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }
  void saveStringToDisk(String key, String content) {
    // print(
    //     '(TRACE) LocalStorageService:_saveStringToDisk. key: $key value: $content');
    _preferences.setString(key, content);
  }
}
