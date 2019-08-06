import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:edukasi_pot/providers/providers.dart';
import 'package:edukasi_pot/screens/screens.dart';
import 'package:edukasi_pot/widgets/builder.dart';

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
    _isAuth = Future.delayed(Duration(milliseconds: 450), () {
      return Provider.of<AuthProvider>(context).isUserAuth;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedFutureBuilder(
    duration: Duration(milliseconds: 450),
    future: _isAuth,
    builder: (context, authSnapshot) {
      switch (authSnapshot.connectionState) {
        case ConnectionState.waiting:
          // Show splash screen when waiting for result.
          return SplashScreen();
        case ConnectionState.done:
          // If result is true, then user is authenticated
          if (authSnapshot.data) {
            return SubjectListScreen();
          }
          break;
        default:
          break;
      }
      return LoginScreen();
    });
  }
}
