import 'package:flutter/material.dart';

import './subject_auth.dart';

class HomeworkScreen extends StatelessWidget {
  static const routeName = '/homeworks';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F6F5),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 100.0),
              _buildHeaderNav(context),
              SizedBox(height: 100.0),
              _buildBody()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderNav(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(),
        Column(
          children: <Widget>[
            Text(
              'Homeworks',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Based on your teaching session',
              style: TextStyle(
                fontSize: 20.0,
                color: Color(0xFFA29C9D),
              ),
            )
          ],
        ),
        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16.0),
          child: InkWell(
            onTap: () => Navigator.pushReplacementNamed(context, SubjectAuthScreen.routeName),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: Color(0xFFDBE7F9),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Text(
                'Continue',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFF5771AD),
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBody() {
    return Container();
  }
}
