import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:edukasi_pot/states/auth.dart';

import './login.dart';
import './school.dart';
import './splash.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Future<bool> _isAuth;

  @override
  void initState() {
    super.initState();
    // Future delayed so context is accessible.
    _isAuth = Future.delayed(Duration(milliseconds: 1000), () {
      return Provider.of<AdminAuthNotifier>(context).isAdminAuth;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // TODO: Autologin (to server) operation here,
        future: _isAuth,
        builder: (context, authSnapshot) {
          switch (authSnapshot.connectionState) {
            case ConnectionState.waiting:
              // Show splash screen when waiting for result.
              // TODO: Animation when splash screen disposed.
              return SplashScreen();
            case ConnectionState.done:
              // If result is true, then user is authenticated
              if (authSnapshot.data) {
                return SchoolScreen();
              }
              break;
            default:
              break;
          }
          return LoginScreen();
        });
  }
}