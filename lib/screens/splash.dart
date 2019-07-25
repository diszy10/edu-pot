import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/splash';

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
