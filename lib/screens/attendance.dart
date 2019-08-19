import 'package:edukasi_pot/shared/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:edukasi_pot/providers/providers.dart';
import 'package:edukasi_pot/screens/screens.dart';

class AttendanceScreen extends StatelessWidget {
  static const routeName = '/attendance';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Students(),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: edgeSymmetric(context, 7, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(50.0),
                        child: Container(
                          padding: EdgeInsets.all(32.0),
                          child: Icon(
                            Icons.arrow_back,
                            size: 28.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Student Attendance',
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      verticalSpaceSmall(context),
                      Text(
                        'Who missed class today ?',
                        style: TextStyle(
                          color: Color(0xFFA29C9D),
                          fontSize: 18.0,
                        ),
                      )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFDBE7F9),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, NoteScreen.routeName),
                        borderRadius: BorderRadius.circular(16.0),
                        child: Padding(
                          padding: edgeSymmetric(context, 3, 1.5),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              color: Color(0xFF5771AD),
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            StudentList()
          ],
        ),
      ),
    );
  }
}

class StudentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loadedStudent = Provider.of<Students>(context);
    final students = loadedStudent.items;
    return Padding(
      padding: edgeHorizontal(context, 5),
      child: GridView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: students.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: students[i],
          child: StudentItem(),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.15,
          crossAxisSpacing: 25,
          mainAxisSpacing: 0,
        ),
      ),
    );
  }
}

class StudentItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final student = Provider.of<Student>(context);
    return Container(
      margin: edgeSymmetric(context, 2, 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.10,
            height: MediaQuery.of(context).size.width * 0.10,
            decoration: student.isAbsent == true
                ? BoxDecoration(
                    border: Border.all(color: Colors.white, width: 5.0),
                    borderRadius: BorderRadius.circular(32.0),
                    color: Color(0xFFFF5B33).withOpacity(0.8),
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3), BlendMode.dstATop),
                      fit: BoxFit.cover,
                      image: AssetImage(student.image),
                    ),
                  )
                : BoxDecoration(
                    border: Border.all(color: Colors.white, width: 5.0),
                    borderRadius: BorderRadius.circular(32.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(student.image),
                    ),
                  ),
            child: AspectRatio(
              aspectRatio: 12 / 6,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => student.toggleAbsent(),
                  // onTap: () => showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) =>
                  //       ChangeNotifierProvider.value(
                  //     value: student,
                  //     child: _ActionModal(),
                  //   ),
                  // ),
                  borderRadius: BorderRadius.circular(32.0),
                  child: SizedBox(),
                ),
              ),
            ),
          ),
          verticalSpaceSmall(context),
          Text(
            student.name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
