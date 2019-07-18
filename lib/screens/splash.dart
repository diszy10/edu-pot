import 'package:edukasi_pot/screens/home.dart';
import 'package:edukasi_pot/screens/login.dart';
import 'package:edukasi_pot/states/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Need to use future.delayed
    // because context is not available on initState
    Future.delayed(Duration(milliseconds: 750), () {
      final auth = Provider.of<AuthNotifier>(context);
      if (auth.isAuthenticated) {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } else if (!auth.isAuthenticated) {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Icon(
          Icons.rss_feed,
          size: 100,
          color: Colors.white,
        ),
      ),
    );
  }
}
