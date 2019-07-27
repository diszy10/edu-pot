import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:edukasi_pot/helpers/helpers.dart';

class Auth with Token, ChangeNotifier {
  static const loginPath = '/login';
  final Dio _dio = Api().dio;

  Future<bool> get isUserAuth async {
    final _tok = await getToken();
    return _tok != null && _tok != '' ? true : false;
  }

  Future<bool> login(String email, String password) async {
    String _token = await _postLogin(email, password);
    if (_token?.isNotEmpty ?? false) {
      setToken(_token);
      notifyListeners();
    }
  }

  Future<bool> logout() async {
    delToken();
    notifyListeners();
    return true;
  }

  Future<String> _postLogin(String email, String password) async {
    Response response =
        await _dio.post(loginPath, data: {'email': email, 'password': password});
    return response.data['token'];
  }
}
