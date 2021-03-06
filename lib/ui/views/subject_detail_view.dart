import 'dart:io';

import 'package:edukasi_pot/core/enums/viewstate.dart';
import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/core/viewmodels/viewmodels.dart';
import 'package:edukasi_pot/ui/shared/shared.dart';
import 'package:edukasi_pot/ui/views/base_view.dart';
import 'package:edukasi_pot/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SubjectDetailView extends StatelessWidget {
  final Subject subject;

  const SubjectDetailView({@required this.subject});

  @override
  Widget build(BuildContext context) {
    final startTime = DateFormat.Hm().format(subject.startTime);
    final duration = subject.endTime.difference(subject.startTime).inMinutes;

    return BaseView<SubjectModel>(
      onModelReady: (model) => model.addSubjectToStream(subject),
      builder: (context, model, _) => Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              // Background
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg-subject.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Widgets
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Class label & logout button
                    Container(
                      height: heightBox(context, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          horizontalSpace(context, 20),
                          _ClassLabel(subject),
                          _LogoutButton(model)
                        ],
                      ),
                    ),

                    // Subject detail
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Subject schedule time
                        Text(
                          'UPCOMING CLASS / $startTime ($duration MINS)',
                          style: TextStyle(
                            color: Color(0xFF54B9A6),
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        verticalSpace(context, 2),

                        // Subject title
                        GradientText(
                          text: subject.title,
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
                      ],
                    ),

                    // Buttons
                    Column(
                      children: <Widget>[
                        _ContinueButton(subject, model),
                        verticalSpaceMedium(context),
                        _ChooseScheduleButton(model),
                        verticalSpaceLarge(context),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClassLabel extends StatelessWidget {
  final Subject subject;

  const _ClassLabel(this.subject);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: subject.klass,
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
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: Text(
                'Class ' + subject.klass,
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
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  final SubjectModel model;

  const _LogoutButton(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: edgeSymmetric(context, 4, 2),
      child: Material(
        color: Colors.transparent,
        child: BaseView<AuthModel>(
          builder: (context, model, child) => InkWell(
            onTap: () {
              model.logout();
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
                      letterSpacing: 1.2,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  final Subject subject;
  final SubjectModel model;

  const _ContinueButton(this.subject, this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightBox(context, 17),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Button
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
                  onTap: () {
                    try {
                      model.getModules(subject.id);
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          content: Text(e.toString()),
                        ),
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(16.0),
                  child: Center(
                    child: model.state == ViewState.Busy
                        ? Container(
                            padding: Platform.isIOS
                                ? edgeVertical(context, 3)
                                : edgeVertical(context, 2.15),
                            child: Loader(),
                          )
                        : Text(
                            'Continue as ${Provider.of<User>(context).name}',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                  ),
                ),
              ),
            ),
          ),

          /// User image
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
                  image: AssetImage(Provider.of<User>(context).imageUrl),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChooseScheduleButton extends StatelessWidget {
  final SubjectModel model;

  const _ChooseScheduleButton(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthBox(context, 35),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.white),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            model.navigateToSubjectList();
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
    );
  }
}
