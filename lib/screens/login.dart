import 'package:edukasi_pot/screens/home.dart';
import 'package:edukasi_pot/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

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
              _buildLogin(context)
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

  Widget _buildLogin(BuildContext context) {
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
                onTap: () => Navigator.pushReplacementNamed(context, HomeScreen.routeName),
                borderRadius: BorderRadius.circular(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 80.0,
                      height: 80.0,
                      margin: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://image.shutterstock.com/image-photo/headshot-portrait-happy-ginger-girl-260nw-623804987.jpg'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
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
                          Text(
                            'Login with Facial Recognition',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color(0xFF9AA8AE),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
        SizedBox(height: 50.0),

        /// Failed to Login
        Container(
          child: Text('Failed to Log in ?',
              style: TextStyle(
                  color: Color(0xFF53A49F),
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0)),
        ),
        SizedBox(height: 50.0)
      ],
    );
  }
}
