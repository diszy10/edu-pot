import 'package:edukasi_pot/screens/home.dart';
import 'package:edukasi_pot/screens/login.dart';
import 'package:edukasi_pot/screens/splash.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class EdukasiPotRouter {
  static Router router = Router();

  static Handler _splashHandler = Handler(
      handlerFunc: (BuildContext ctx, Map<String, dynamic> params) =>
          SplashScreen());

  static Handler _loginHandler = Handler(
      handlerFunc: (BuildContext ctx, Map<String, dynamic> params) =>
          LoginScreen());

  static Handler _homeHandler = Handler(
      handlerFunc: (BuildContext ctx, Map<String, dynamic> params) =>
          HomeScreen());

  static void setupRouter() {
    router.define('/',
        handler: _splashHandler, transitionType: TransitionType.fadeIn);

    router.define(
      'login',
      handler: _loginHandler
    );

    router.define('home', handler: _homeHandler);
  }
}
