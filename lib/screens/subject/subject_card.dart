import 'package:edukasi_pot/helpers/helpers.dart';
import 'package:edukasi_pot/shared/ui_helper.dart';
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
        Container(
          height: heightBox(context, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              horizontalSpace(context, 20),
              _ClassBanner(
                subjectId: subject.id,
                klassName: subject.klass,
              ),
              Container(
                margin: edgeSymmetric(context, 4, 2),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      await logout(context);
                    },
                    borderRadius: BorderRadius.circular(32.0),
                    child: Container(
                      padding: edgeSymmetric(context, 1, 1),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              // fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _SubjectInfo(
          subjectId: subject.id,
          subjectName: subject.name,
          startTime: subject.startTime,
          endTime: subject.endTime,
        ),
        _SubjectButtons(subject: subject)
      ];

      child = SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widgets,
          ),
        ),
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
        // SizedBox(height: 32.0),
      ];

      child = Container(
        width: widthSmall(context),
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
              blurRadius: 16.0,
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
            borderRadius: BorderRadius.circular(16.0),
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
          width: widthBox(context, 16),
          height: heightBox(context, 7),
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
                color: Colors.white,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
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
    // final endHm = DateFormat.Hm().format(endTime);

    final diffMin = endTime.difference(startTime).inMinutes;
    return 'UPCOMING CLASS / $startHm ($diffMin MINS)';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: timeTag,
            child: Material(
              color: Colors.transparent,
              child: Text(
                _timeInfo(),
                style: TextStyle(
                  color: Color(0xFF54B9A6),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
          verticalSpace(context, 2),
          Hero(
            tag: nameTag,
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
        Container(
          height: heightBox(context, 16.5),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: widthBox(context, 35),
                  height: heightBox(context, 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(9.0, 8.0),
                        blurRadius: 16.0,
                        spreadRadius: 4.0,
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, ModuleScreen.routeName),
                      borderRadius: BorderRadius.circular(16.0),
                      child: Padding(
                        padding: edgeSymmetric(context, 4, 3),
                        child: Center(
                          child: Text(
                            'Continue as Mrs. Airin Rachmi',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 70.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 4.0),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://suaratangsel.com/wp-content/uploads/2017/01/airin.jpg'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpaceMedium(context),
        Container(
          width: widthBox(context, 35),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: Colors.white),
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
                padding: edgeSymmetric(context, 4, 2.5),
                child: Center(
                  child: Text(
                    'Or Choose Your Schedule',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        verticalSpaceLarge(context),
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
          width: widthBox(context, 12),
          height: heightBox(context, 5),
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
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
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
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
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
          verticalSpace(context, 1.5),
          Hero(
            tag: timeTag,
            child: Material(
              color: Colors.transparent,
              child: Text(
                _timeInfo(),
                style: TextStyle(
                  color: Color(0xff494F55),
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  // letterSpacing: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
