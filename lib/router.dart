import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import './screens/home.dart';
import './screens/login.dart';

class EdukasiPotRouter {
  static Router router = Router();

  static Handler _loginHandler = Handler(handlerFunc: (BuildContext ctx, Map<String, dynamic> params) => LoginPage());

  static Handler _homeHandler = Handler(handlerFunc: (BuildContext ctx, Map<String, dynamic> params) => HomePage());

  static void setupRouter() {
    router.define(
      'login',
      handler: _loginHandler,
    );

    router.define(
      'home',
      handler: _homeHandler,
      transitionType: TransitionType.native
    );
  }
}