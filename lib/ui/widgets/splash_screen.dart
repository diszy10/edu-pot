import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFace0f9),
                Color(0xFFfff1eb),
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topCenter,
              stops: [0, 1],
            ),
          ),
        ),
        Center(
          child: AspectRatio(
            aspectRatio: 4.0,
            child: Image.asset('assets/graphics/edukasi-mark.png'),
          ),
        ),
      ],
    );
  }
}
