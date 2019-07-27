import 'package:flutter/material.dart';

class SubjectListScreen extends StatefulWidget {
  static const routeName = '/subject-list';
  @override
  _SubjectListScreenState createState() => _SubjectListScreenState();
}

class _SubjectListScreenState extends State<SubjectListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text('TEST')],
      ),
    );
  }
}
