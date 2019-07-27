import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

var _users = [
  {'email': 'teacher1@edukasi.com', 'password': '12345', 'token': 'teacher1'},
  {'email': 'teacher2@edukasi.com', 'password': '12345', 'token': 'teacher2'}
];

ResponseBody login(RequestOptions options) {
  String text;
  int statusCode;
  bool isAuth = false;

  Map data = options.data;
  String email = data['email'];
  String password = data['password'];

  for (var user in _users) {
    if (email == user['email'] && password == user['password']) {
      statusCode = 200;
      text = jsonEncode({'token': user['token']});
      isAuth = true;
    }
  }

  if (!isAuth) {
    statusCode = 401;
    text = jsonEncode({'message': 'Wrong Credential'});
  }

  return ResponseBody.fromString(text, statusCode,
      headers: DioHttpHeaders.fromMap({
        HttpHeaders.contentTypeHeader: ContentType.json,
      }));
}
