import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/core/viewmodels/viewmodels.dart';
import 'package:edukasi_pot/ui/shared/shared.dart';
import 'package:edukasi_pot/ui/views/base_view.dart';
import 'package:edukasi_pot/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SubjectListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<SubjectModel>(
      onModelReady: (model) {
        model.getSubjects(Provider.of<User>(context).id);
        model.getSubjectInSession();
      },
      builder: (context, model, child) => Scaffold(
        backgroundColor: Color(0xFFF6F8F9),
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Title page
                Text(
                  'YOUR SCHEDULE TODAY',
                  style: TextStyle(
                    color: Color(0xff3D3D3D),
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.8,
                  ),
                  textAlign: TextAlign.center,
                ),
                verticalSpaceMedium(context),

                // Subject list
                Container(
                  margin: edgeLeft(context, 2),
                  height: widthBox(context, 25),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: model.subjects.length,
                    itemBuilder: (BuildContext context, int index) {
                      var subject = model.subjects[index];
                      return Container(
                        padding: edgeSymmetric(context, 1, 2),
                        child: _SubjectItem(
                          subject: subject,
                          subjectInSession: subject == model.subjectInSession,
                          onTap: () =>
                              model.navigateToSubjectDetail(arguments: subject),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SubjectItem extends StatelessWidget {
  final Subject subject;
  final bool subjectInSession;
  final Function onTap;

  const _SubjectItem({
    this.subject,
    this.onTap,
    this.subjectInSession,
  });

  @override
  Widget build(BuildContext context) {
    final startTime = DateFormat.Hm().format(subject.startTime);
    final endTime = DateFormat.Hm().format(subject.endTime);
    final duration = subject.endTime.difference(subject.startTime).inMinutes;

    return Container(
      width: widthSmall(context),
      decoration: BoxDecoration(
        border:
            subjectInSession ? Border.all(color: Colors.red, width: 4.0) : null,
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
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Class label
              Hero(
                tag: subject.klass,
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
                    child: Material(
                      color: Colors.transparent,
                      child: Center(
                        child: Text(
                          'Class ' + subject.klass,
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
                ),
              ),
              // Subject title & schedule time
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      subject.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    verticalSpace(context, 1.5),
                    Text(
                      '$startTime - $endTime ($duration MINS)',
                      style: TextStyle(
                        color: Color(0xff494F55),
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
