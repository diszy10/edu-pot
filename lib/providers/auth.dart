import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:edukasi_pot/helpers/helpers.dart';
import 'package:edukasi_pot/models/models.dart';

class AuthProvider with AuthService, UserToken, ChangeNotifier {
  final AppDatabase _db;
  final Api _api;

  AuthProvider(this._db, this._api);

  Future<bool> get isUserAuth async {
    final _tok = await getToken();
    return _tok != null && _tok != '' ? true : false;
  }

  Future<void> login(String email, String password) async {
    String _token = await _postLogin(email, password);
    if (_token?.isNotEmpty ?? false) {
      setToken(_token);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await delToken();
    notifyListeners();
  }
}

mixin AuthService {
  static const loginPath = '/login';
  Api _api;

  Future<String> _postLogin(String email, String password) async {
    Response response = await _api.dio
        .post(loginPath, data: {'email': email, 'password': password});
    return response.data['token'];
  }
}
