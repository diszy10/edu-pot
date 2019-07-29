import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

var _subjectList = {
  'teacher1': [
    {
      'id': 20,
      'name': 'Math',
      'klass': 'Class VIII - B',
      'startTime': '2019-07-30T10:00:00Z',
      'endTime': '2019-07-30T11:15:00Z'
    },
    {
      'id': 25,
      'name': 'Physics',
      'klass': 'Class VII - C',
      'startTime': '2019-07-29T08:00:00Z',
      'endTime': '2019-07-29T08:45:00Z'
    },
    {
      'id': 12,
      'name': 'Math',
      'klass': 'Class VII - B',
      'startTime': '2019-07-30T13:15:00Z',
      'endTime': '2019-07-30T14:00:00Z'
    }
  ],
  'teacher2': [{
      'id': 15,
      'name': 'History',
      'klass': 'Class V - B',
      'startTime': '2019-07-29T09:00:00Z',
      'endTime': '2019-07-29T09:45:00Z'
    },
    {
      'id': 22,
      'name': 'History',
      'klass': 'Class IV - C',
      'startTime': '2019-07-31T10:00:00Z',
      'endTime': '2019-07-31T11:45:00Z'
    },
    {
      'id': 8,
      'name': 'Geography',
      'klass': 'Class V - A',
      'startTime': '2019-07-30T13:15:00Z',
      'endTime': '2019-07-30T14:00:00Z'
    }]
};

Future<ResponseBody> subjectList(RequestOptions options) async {
  String text;
  int statusCode;
  bool isAuth = false;

  Map headers = options.headers;
  String token = headers['token'];
  if (token != null && _subjectList.containsKey(token)) {
    isAuth = true;
    statusCode = 202;
    text = json.encode({'data': _subjectList[token]});
  } else {
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
