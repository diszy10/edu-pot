import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: AspectRatio(
          aspectRatio: 4.0,
          child: Image.asset('assets/graphics/edukasi-mark.png'),
        ),
      ),
    );
  }
}
