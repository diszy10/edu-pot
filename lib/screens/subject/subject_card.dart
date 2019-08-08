import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:edukasi_pot/models/models.dart';
import 'package:edukasi_pot/providers/providers.dart';
import 'package:edukasi_pot/screens/screens.dart';
import 'package:edukasi_pot/widgets/widgets.dart';

enum SubjectCardSetting { card, screen }

class SubjectCard extends StatelessWidget {
  const SubjectCard({
    Key key,
    @required this.subject,
    @required this.heroTag,
    @required this.setting,
  }) : super(key: key);

  final Subject subject;
  final String heroTag;
  final SubjectCardSetting setting;

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    if (setting == SubjectCardSetting.screen) {
      widgets.addAll([
        _ClassBanner(
          subjectId: subject.id,
          klassName: subject.klass,
        ),
        _SubjectInfo(
          subjectId: subject.id,
          subjectName: subject.name,
          startTime: subject.startTime,
          endTime: subject.endTime,
        ),
        _SubjectButtons(subjectId: subject.id)
      ]);
    } else {
      widgets.addAll([
        _ClassBannerCard(
          subjectId: subject.id,
          klassName: subject.klass,
        ),
        _SubjectInfoCard(
          subjectId: subject.id,
          subjectName: subject.name,
          startTime: subject.startTime,
          endTime: subject.endTime,
        ),
      ]);
    }
    return Hero(
      tag: heroTag,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widgets,
      ),
    );
  }
}

/// Screen Widgets

class _ClassBanner extends StatelessWidget {
  final int subjectId;
  final String klassName;

  const _ClassBanner(
      {Key key, @required this.subjectId, @required String this.klassName})
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
          child: Material(
            color: Colors.transparent,
            child: Text(
              klassName,
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class _SubjectInfo extends StatelessWidget {
  final int subjectId;
  final String subjectName;
  final DateTime startTime;
  final DateTime endTime;

  const _SubjectInfo(
      {Key key,
      @required this.subjectId,
      @required this.subjectName,
      @required this.startTime,
      @required this.endTime})
      : super(key: key);

  String _timeInfo() {
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
            _timeInfo(),
            style: TextStyle(
              color: Color(0xFF54B9A6),
              fontSize: 24.0,
            ),
          ),
          SizedBox(height: 24.0),

          /// Subject text
          Material(
            color: Colors.transparent,
            child: GradientText(
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
            ),
          ),
        ],
      ),
    );
  }
}

class _SubjectButtons extends StatelessWidget {
  final int subjectId;

  const _SubjectButtons({@required this.subjectId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        /// Continue
        Container(
          width: 300.0,
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
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50.0,
          child: Center(
            child: Text(
              'or',
              style: TextStyle(
                color: Color(0xFF54B9A6),
              ),
            ),
          ),
        ),
        // Choose schedules
        Container(
          width: 300.0,
          decoration: BoxDecoration(
            color: Color(0xFFDBE7F9),
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
              onTap: () async {
                var _list =
                    await Provider.of<SubjectProvider>(context, listen: false)
                        .subjectList;
                Navigator.of(context).pushReplacementNamed(
                    SubjectListScreen.routeName,
                    arguments: RouteArgument(
                        from: SubjectScreen.routeName, obj: _list));
              },
              borderRadius: BorderRadius.circular(16.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Choose Schedules',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF5771AD),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 50.0)
      ],
    );
  }
}

/// Card Widgets

class _ClassBannerCard extends StatelessWidget {
  final int subjectId;
  final String klassName;

  const _ClassBannerCard(
      {Key key, @required this.subjectId, @required String this.klassName})
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
          child: Material(
            color: Colors.transparent,
            child: Text(
              klassName,
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class _SubjectInfoCard extends StatelessWidget {
  final int subjectId;
  final String subjectName;
  final DateTime startTime;
  final DateTime endTime;

  const _SubjectInfoCard(
      {Key key,
      @required this.subjectId,
      @required this.subjectName,
      @required this.startTime,
      @required this.endTime})
      : super(key: key);

  String _timeInfo() {
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
            _timeInfo(),
            style: TextStyle(
              color: Color(0xFF54B9A6),
              fontSize: 24.0,
            ),
          ),
          SizedBox(height: 24.0),

          /// Subject text
          Material(
            color: Colors.transparent,
            child: GradientText(
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
            ),
          ),
        ],
      ),
    );
  }
}
