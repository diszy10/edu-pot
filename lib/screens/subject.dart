import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:edukasi_pot/states/auth.dart';
import 'package:edukasi_pot/widgets/widgets.dart';

import './screens.dart';

class SubjectScreen extends StatelessWidget {
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
              _ClassBanner(),
              _SubjectInfo(),
              _Subject()
            ],
          ),
        ),
      ),
    );
  }
}

class _Subject extends StatelessWidget {
  const _Subject({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
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
              onTap: () => Navigator.pushNamed(context, ModuleScreen.routeName),
              borderRadius: BorderRadius.circular(16.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 80.0,
                    height: 80.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://image.shutterstock.com/image-photo/headshot-portrait-happy-ginger-girl-260nw-623804987.jpg'),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Natalia Napitupulu',
                          style: TextStyle(
                            color: Color(0xFF2C3235),
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(
                        height: 8.0,
                      ),
                      Center(
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFF9AA8AE),
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 50.0),

        /// Logout
        Container(
          child: InkWell(
            onTap: () async {
              final auth = Provider.of<AuthNotifier>(context, listen: false);
              auth.logout();
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
            child: Text('Log out',
                style: TextStyle(
                    color: Color(0xFF53A49F),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0)),
          ),
        ),
        SizedBox(height: 50.0),
        SizedBox(height: 100.0),
      ],
    );
  }
}

class _SubjectInfo extends StatelessWidget {
  const _SubjectInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class _ClassBanner extends StatelessWidget {
  const _ClassBanner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
