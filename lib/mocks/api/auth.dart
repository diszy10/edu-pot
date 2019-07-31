import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

var _users = [
  {'email': 'teach1@ed.com', 'password': '12345', 'token': 'teacher1'},
  {'email': 'teach2@ed.com', 'password': '12345', 'token': 'teacher2'}
];

Future<ResponseBody> login(RequestOptions options) async {
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

  // Simulate latency
  Future.delayed(Duration(seconds: 1));

  return ResponseBody.fromString(text, statusCode,
      headers: DioHttpHeaders.fromMap({
        HttpHeaders.contentTypeHeader: ContentType.json,
      }));
}
