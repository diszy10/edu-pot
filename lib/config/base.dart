import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

enum Environment { DEV, PROD }

class BaseConfig {
  BaseConfig({
    @required this.appName,
    @required this.env,
    @required this.baseUrl,
  });

  final String appName, baseUrl;
  final Environment env;
}
