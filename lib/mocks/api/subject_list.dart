import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

var _subjectList = {
  'teacher1': [
    {
      'id': 20,
      'name': 'Math & Logic',
      'klass': 'Class 5A',
      'startTime': '2019-07-30T10:00:00Z',
      'endTime': '2019-07-30T10:45:00Z'
    },
    {
      'id': 25,
      'name': 'Math & Logic',
      'klass': 'Class 5A',
      'startTime': '2019-07-30T08:00:00Z',
      'endTime': '2019-07-30T08:45:00Z'
    },
    {
      'id': 12,
      'name': 'Math & Logic',
      'klass': 'Class 5B',
      'startTime': '2019-07-30T13:15:00Z',
      'endTime': '2019-07-30T14:00:00Z'
    },
    {
      'id': 23,
      'name': 'Physics',
      'klass': 'Class 6A',
      'startTime': '2019-07-30T14:15:00Z',
      'endTime': '2019-07-30T15:00:00Z'
    },
    {
      'id': 14,
      'name': 'Physics',
      'klass': 'Class 5B',
      'startTime': '2019-07-30T15:15:00Z',
      'endTime': '2019-07-30T16:00:00Z'
    },
    {
      'id': 9,
      'name': 'Math & Logic',
      'klass': 'Class 5C',
      'startTime': '2019-07-30T11:00:00Z',
      'endTime': '2019-07-30T11:45:00Z'
    }
  ],
  'teacher2': [{
      'id': 15,
      'name': 'History',
      'klass': 'Class 6B',
      'startTime': '2019-07-30T09:00:00Z',
      'endTime': '2019-07-30T09:45:00Z'
    },
    {
      'id': 22,
      'name': 'History',
      'klass': 'Class 6C',
      'startTime': '2019-07-30T10:00:00Z',
      'endTime': '2019-07-30T10:45:00Z'
    },
    {
      'id': 8,
      'name': 'Geography',
      'klass': 'Class 5A',
      'startTime': '2019-07-30T13:15:00Z',
      'endTime': '2019-07-30T14:00:00Z'
    }]
};

Future<ResponseBody> subjectList(RequestOptions options) async {
  String text;
  int statusCode;

  Map headers = options.headers;
  String token = headers['token'];
  if (token != null && _subjectList.containsKey(token)) {
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
