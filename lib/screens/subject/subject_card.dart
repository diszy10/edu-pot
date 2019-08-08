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
    this.selected = false,
  }) : super(key: key);

  final Subject subject;
  final SubjectCardSetting setting;
  final bool selected;

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
        _SubjectButtons(subjectId: subject.id)
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
      ];

      child = Container(
        width: 420.0,
        margin: EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          border: selected ? Border.all(
            color: Color(0xFFFF5B30),
            width: 6.0,
          ) : null,
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              offset: Offset(2.0, 8.0),
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(SubjectScreen.routeName,
                  arguments: RouteArgument(
                      from: SubjectListScreen.routeName, obj: subject));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
      {Key key, @required this.subjectId, @required String this.klassName})
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
                    fontWeight: FontWeight.bold),
              ),
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

  final String klassTag;

  const _ClassBannerCard(
      {Key key, @required this.subjectId, @required String this.klassName})
      : klassTag = '$subjectId:$klassName',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: klassTag,
      child: ClipPath(
        clipper: BannerClipper(),
        child: Container(
          width: 208,
          height: 36,
          decoration: BoxDecoration(
            color: Color(0xFFFF5B30),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
          ),
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: Text(
                klassName,
                style: TextStyle(
                    fontSize: 16.0,
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
    return '$startHm ~ $endHm ($diffMin Mins)';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 96.0),
      child: Column(
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
                    fontSize: 64.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 24.0),
          Hero(
            tag: timeTag,
            child: Material(
              color: Colors.transparent,
              child: Text(
                _timeInfo(),
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
