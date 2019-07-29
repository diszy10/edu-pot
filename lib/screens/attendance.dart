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
              children: <Widget>[
                SizedBox(height: 50.0),
                _HeaderNav(),
                SizedBox(height: 50.0),
                _StudentList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderNav extends StatelessWidget {
  const _HeaderNav({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
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
          Column(
            children: <Widget>[
              Text(
                'Student Attendance',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Who missed class today?',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFFA29C9D),
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
                onTap: () => Navigator.pushReplacementNamed(
                    context, SubjectScreen.routeName),
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFF5771AD),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
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
          physics: NeverScrollableScrollPhysics(),
          itemCount: students.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: students[i],
            child: _StudentItem(),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
            crossAxisSpacing: 25,
            mainAxisSpacing: 25,
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
      // color: Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 120.0,
            height: 120.0,
            child: InkWell(
              onTap: () {},
              child: AspectRatio(
                aspectRatio: 12 / 6,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32.0),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(student.image)),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            student.name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          )
        ],
      ),
    );
  }
}
