import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

Future<ResponseBody> subjectList(RequestOptions options) async {
  String text;
  int statusCode;
  bool isAuth = false;

  Map data = options.data;
  String email = data['email'];
  String password = data['password'];

  if (!isAuth) {
    statusCode = 401;
    text = jsonEncode({'message': 'Wrong Credential'});
  }

  // Simulate latency
  Future.delayed(Duration(seconds: 2));

  return ResponseBody.fromString(text, statusCode,
      headers: DioHttpHeaders.fromMap({
        HttpHeaders.contentTypeHeader: ContentType.json,
      }));
}
