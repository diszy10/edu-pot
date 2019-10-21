import 'package:edukasi_pot/core/constants/route_paths.dart' as routes;
import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToReplacement(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> logout() {
    return navigatorKey.currentState.pushNamedAndRemoveUntil(
        routes.Login, (Route<dynamic> route) => false);
  }

  bool navigateBack() {
    return navigatorKey.currentState.pop();
  }
}
