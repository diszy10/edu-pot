import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:edukasi_pot/widgets/widgets.dart';

class SubjectAuthScreen extends StatelessWidget {
  static const routeName = '/subject';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00716B),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildClassBanner(),
              _buildSubjectInfo(),
              _buildSubject(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClassBanner() {
    return ClipPath(
      clipper: BannerClipper(),
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFFFF5B30),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          ),
        ),
        child: Center(
          child: Text(
            'Class 5A',
            style: TextStyle(
                fontSize: 24.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectInfo() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /// Upcoming class text
          Text(
            'UPCOMING CLASS / 10:30 (90 MINS)',
            style: TextStyle(
              color: Color(0xFF54B9A6),
              fontSize: 24.0,
            ),
          ),
          SizedBox(height: 24.0),

          /// Subject text
          GradientText(
            text: 'Math & Logic',
            gradient: LinearGradient(
              colors: [
                Color(0xFFE9FCD8),
                Color(0xFFC6EDF8),
              ],
            ),
            style: TextStyle(
                color: Color(0xFFE9FCD9),
                fontSize: 90.0,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  void _continue(BuildContext context) {
    return null;
  }

  Widget _buildSubject(BuildContext context) {
    return Column(
      children: <Widget>[
        /// Login button
        Container(
          width: 420.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(9.0, 8.0),
                  blurRadius: 16.0,
                  spreadRadius: 4.0),
            ],
          ),
          child: Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: () => _continue(context),
                  borderRadius: BorderRadius.circular(16.0),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(24.0),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                            fontSize: 24.0,
                            color: Color(0xFF2C3235),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ))),
        ),
        SizedBox(height: 100.0),
      ],
    );
  }
}
