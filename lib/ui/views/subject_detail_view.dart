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
              /// Background
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/graphics/bg-subject.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// Widgets
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    /// Class banner and logout button
                    Container(
                      height: heightBox(context, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          horizontalSpace(context, 20),

                          /// Class banner
                          Hero(
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
                          ),

                          /// Logout button
                          Container(
                            margin: edgeSymmetric(context, 4, 2),
                            child: Material(
                              color: Colors.transparent,
                              child: BaseView<LoginModel>(
                                builder: (context, model, child) => InkWell(
                                  onTap: () async {
                                    await model.logout(context);
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
                          ),
                        ],
                      ),
                    ),

                    /// Subject Info
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
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

                    /// Subject buttons
                    Column(
                      children: <Widget>[
                        /// Continue button
                        Container(
                          height: heightBox(context, 17),
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              /// Button
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
                                    child: BaseView<ModuleModel>(
                                      onModelReady: (model) =>
                                          model.getModules(subject.id),
                                      builder: (context, model, _) => InkWell(
                                        onTap: () =>
                                            Navigator.pushReplacementNamed(
                                                context, 'module-detail',
                                                arguments: model.modules[0]),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        child: Center(
                                          child: Text(
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
                              ),

                              /// User image
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  width: 70.0,
                                  height: 70.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 4.0),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          Provider.of<User>(context).imageUrl),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        verticalSpaceMedium(context),

                        /// Choose schedule button
                        Container(
                          width: widthBox(context, 35),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, 'subject-list');
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
