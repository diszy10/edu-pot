import 'dart:io';

import 'package:dio/dio.dart';

import 'package:edukasi_pot/config/config.dart';
import 'package:edukasi_pot/mocks/api/adapter.dart';

class Api {
  static final Api _singleton = Api._internal();

  factory Api() => _singleton;

  Api._internal();

  Dio _dio;

  Dio get dio {
    if (_dio != null) {
      return _dio;
    } else {
      _dio = _initDio();
      return _dio;
    }
  }

  _initDio() {
    BaseOptions options = BaseOptions(
      baseUrl: Config().get(Config.baseUrl),
      headers: {
        HttpHeaders.acceptHeader: ContentType.json,
        HttpHeaders.contentTypeHeader: ContentType.json
      }
    );

    final dio = Dio(options);

    if (Config().get(Config.env) == Env.MOCK) {
      dio.httpClientAdapter = MockAdapter();
    }
    return dio;
  }

  dispose() {
    _dio = null;
  }
}
