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
    @required this.setting,
    this.inSession = false,
  }) : super(key: key);

  final Subject subject;
  final SubjectCardSetting setting;
  final bool inSession;

  @override
  Widget build(BuildContext context) {
    Widget child;
    List<Widget> widgets;

    if (setting == SubjectCardSetting.screen) {
      widgets = <Widget>[
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
        _SubjectButtons(subject: subject)
      ];

      child = Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widgets,
      );
    } else {
      widgets = <Widget>[
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
        SizedBox(height: 32.0),
      ];

      child = Container(
        width: 380.0,
        margin: EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          border: inSession
              ? Border.all(
                  color: Color(0xFFFF5B30),
                  width: 6.0,
                )
              : null,
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              offset: Offset(4.0, 8.0),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                  SubjectScreen.routeName,
                  arguments: RouteArgument(
                      from: SubjectListScreen.routeName, data: subject));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widgets,
            ),
          ),
        ),
      );
    }
    return child;
  }
}

/// Screen Widgets

class _ClassBanner extends StatelessWidget {
  final int subjectId;
  final String klassName;

  final String klassTag;

  const _ClassBanner(
      {Key key, @required this.subjectId, @required this.klassName})
      : klassTag = '$subjectId:$klassName',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: klassTag,
      child: ClipPath(
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
      ),
    );
  }
}

class _SubjectInfo extends StatelessWidget {
  final int subjectId;
  final String subjectName;
  final DateTime startTime;
  final DateTime endTime;

  final String nameTag;
  final String timeTag;

  const _SubjectInfo(
      {Key key,
      @required this.subjectId,
      @required this.subjectName,
      @required this.startTime,
      @required this.endTime})
      : nameTag = '$subjectId:$subjectName',
        timeTag = '$subjectId:$startTime:$endTime',
        super(key: key);

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
          Hero(
            tag: timeTag,
            child: Material(
              color: Colors.transparent,
              child: Text(
                _timeInfo(),
                style: TextStyle(
                  color: Color(0xFF54B9A6),
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
          SizedBox(height: 24.0),

          /// Subject text
          Hero(
            tag: nameTag,
            child: Material(
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
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubjectButtons extends StatelessWidget {
  final Subject subject;

  const _SubjectButtons({@required this.subject});

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
                padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
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
        SizedBox(height: 40.0),
        // Choose schedules
        Container(
          width: 300.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: Colors.white30),
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
                    arguments: SubjectListArgument(
                        from: SubjectScreen.routeName,
                        data: _list,
                        subject: subject));
              },
              borderRadius: BorderRadius.circular(16.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Or Choose Your Schedules',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white54,
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

  final String klassTag;

  const _ClassBannerCard(
      {Key key, @required this.subjectId, @required this.klassName})
      : klassTag = '$subjectId:$klassName',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: klassTag,
      child: ClipPath(
        clipper: BannerClipper(),
        child: Container(
          width: 150,
          height: 45,
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
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
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

  final String nameTag;
  final String timeTag;

  const _SubjectInfoCard(
      {Key key,
      @required this.subjectId,
      @required this.subjectName,
      @required this.startTime,
      @required this.endTime})
      : nameTag = '$subjectId:$subjectName',
        timeTag = '$subjectId:$startTime:$endTime',
        super(key: key);

  String _timeInfo() {
    final startHm = DateFormat.Hm().format(startTime);
    final endHm = DateFormat.Hm().format(endTime);

    final diffMin = endTime.difference(startTime).inMinutes;
    return '$startHm - $endHm ($diffMin MINS)';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(top: 96.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /// Subject text
          Hero(
            tag: nameTag,
            child: Material(
              color: Colors.transparent,
              child: Text(
                subjectName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 12.0),
          Hero(
            tag: timeTag,
            child: Material(
              color: Colors.transparent,
              child: Text(
                _timeInfo(),
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff494F55),
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
          // SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
