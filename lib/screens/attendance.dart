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
        backgroundColor: Color(0xFFF9F6F5),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Top navigation, title page
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.05,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // SizedBox(width: 125.0),
                      Container(
                        margin: EdgeInsets.only(left: 50.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            borderRadius: BorderRadius.circular(50.0),
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_back,
                                size: 28.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Attendances',
                              style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'Who missed class today ?',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xFFA29C9D),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFDBE7F9),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => Navigator.pushNamed(
                                context, NoteScreen.routeName),
                            borderRadius: BorderRadius.circular(16.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 12.0),
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Color(0xFF5771AD),
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
                _StudentList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StudentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loadedStudent = Provider.of<Students>(context);
    final students = loadedStudent.items;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: students.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: students[i],
            child: _StudentItem(),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1.25,
            crossAxisSpacing: 25,
            mainAxisSpacing: 0,
          ),
        ),
      ),
    );
  }
}

class _StudentItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final student = Provider.of<Student>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 5.0),
              borderRadius: BorderRadius.circular(32.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(student.image),
              ),
            ),
            child: AspectRatio(
              aspectRatio: 12 / 6,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => ActionModal()),
                  borderRadius: BorderRadius.circular(32.0),
                  child: SizedBox(),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            student.name,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}

class ActionModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.18,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Color(0xFFF9F6F5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //
              // Close button
              //
              // Align(
              //   alignment: Alignment.topRight,
              //   child: Container(
              //     margin: EdgeInsets.only(bottom: 32.0),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(50.0),
              //       color: Colors.black26,
              //     ),
              //     child: Material(
              //       color: Colors.transparent,
              //       child: InkWell(
              //         onTap: () => Navigator.pop(context),
              //         borderRadius: BorderRadius.circular(50.0),
              //         child: Container(
              //           padding: EdgeInsets.all(5.0),
              //           child: Icon(Icons.close, color: Colors.white),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              
              //
              // Actions button
              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.red[300],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(50.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.calendar_today, color: Colors.white),
                              SizedBox(width: 10.0),
                              Text(
                                'Absent',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.teal[300],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(50.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(Icons.check, color: Colors.white),
                              SizedBox(width: 10.0),
                              Text(
                                'Attend',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
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
            ],
          ),
        ),
      ),
    );
  }
}
