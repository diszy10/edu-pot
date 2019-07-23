import 'package:flutter/material.dart';

class SchoolScreen extends StatefulWidget {
  static const routeName = '/school';

  @override
  _SchoolScreenState createState() => _SchoolScreenState();
}

class _SchoolScreenState extends State<SchoolScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text(
            'School Screen',
            style: TextStyle(fontSize: 28),
          ),
        ),
      );
  }
}