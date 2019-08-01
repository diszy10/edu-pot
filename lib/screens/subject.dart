import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:edukasi_pot/models/models.dart';
import 'package:edukasi_pot/screens/screens.dart';
import 'package:edukasi_pot/widgets/widgets.dart';

class SubjectScreen extends StatelessWidget {
  static const routeName = '/subject';

  final Subject subject;

  const SubjectScreen({Subject this.subject});

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
              _ClassBanner(
                klassName: subject.klass,
              ),
              _SubjectInfo(
                subjectName: subject.name,
                startTime: subject.startTime,
                endTime: subject.endTime,
              ),
              _Subject(subjectId: subject.id)
            ],
          ),
        ),
      ),
    );
  }
}

class _Subject extends StatelessWidget {
  final int subjectId;

  const _Subject({
    Key key,
    @required int this.subjectId,
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
              Navigator.of(context).pop();
            },
            child: Text('Back to List',
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
  final String subjectName;
  final DateTime startTime;
  final DateTime endTime;

  const _SubjectInfo(
      {Key key,
      @required String this.subjectName,
      @required DateTime this.startTime,
      @required DateTime this.endTime})
      : super(key: key);

  String _time_info() {
    final startHm = DateFormat.Hm().format(startTime);
    final endHm = DateFormat.Hm().format(endTime);

    final diffMin = endTime.difference(startTime).inMinutes;
    return '$startHm ~ $endHm ($diffMin Mins)';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /// Upcoming class text
          Text(
            _time_info(),
            style: TextStyle(
              color: Color(0xFF54B9A6),
              fontSize: 24.0,
            ),
          ),
          SizedBox(height: 24.0),

          /// Subject text
          GradientText(
            text: subjectName,
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
  final String klassName;

  const _ClassBanner({Key key, @required String this.klassName})
      : super(key: key);

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
            klassName,
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
