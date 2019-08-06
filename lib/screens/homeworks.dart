import 'dart:math';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:edukasi_pot/providers/providers.dart';
import 'package:edukasi_pot/screens/screens.dart';

class HomeworkScreen extends StatelessWidget {
  static const routeName = '/homeworks';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Homeworks(),
      child: Scaffold(
        backgroundColor: Color(0xFFF9F6F5),
        body: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 60.0),
                _HeaderNav(),
                SizedBox(height: 60.0),
                _HomeworkList()
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
          SizedBox(width: 150.0),
          Column(
            children: <Widget>[
              Text(
                'Homeworks',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Based on your teaching session',
                style: TextStyle(
                  fontSize: 16.0,
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
                onTap: () =>
                    Navigator.pushNamed(context, AttendanceScreen.routeName),
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                        fontSize: 16.0,
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

class _HomeworkList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loadedHomeworks = Provider.of<Homeworks>(context);
    final homeworks = loadedHomeworks.item;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: homeworks.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: homeworks[i],
            child: _HomeworkCard(),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 16 / 9,
            crossAxisSpacing: 25,
            mainAxisSpacing: 25,
          ),
        ),
      ),
    );
  }
}

class _HomeworkCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homework = Provider.of<Homework>(context);

    final List<Color> colors = [
      Color(0xFF007789),
      Color(0xFF3D85D3),
      Color(0xFF34BA9C),
      Color(0xFFB57E55),
      Color(0xFFF62B84),
      Color(0xFFA0B658)
    ];

    final Random random = Random();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: colors[random.nextInt(6)],
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            offset: Offset(4.0, 8.0),
            blurRadius: 8.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => showDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) =>
                HomeworkModal(title: homework.title),
          ),
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            padding: EdgeInsets.all(32.0),
            child: Center(
              child: Text(
                homework.title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeworkModal extends StatelessWidget {
  final String title;

  const HomeworkModal({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      Color(0xFF007789),
      Color(0xFF3D85D3),
      Color(0xFF34BA9C),
      Color(0xFFB57E55),
      Color(0xFFF62B84),
      Color(0xFFA0B658)
    ];

    final Random random = Random();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.3,
          padding: EdgeInsets.all(50.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: colors[random.nextInt(6)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.black26,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2018),
                          lastDate: DateTime(2030),
                          builder: (BuildContext context, Widget child) {
                            return Theme(
                              data: ThemeData.dark(),
                              child: child,
                            );
                          },
                        ),
                        borderRadius: BorderRadius.circular(50.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.flag, color: Colors.white),
                              SizedBox(width: 10.0),
                              Text(
                                'Next Session',
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
                      color: Colors.white,
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
                              Icon(Icons.send, color: Colors.black),
                              SizedBox(width: 10.0),
                              Text(
                                'Distribute',
                                style: TextStyle(
                                  color: Colors.black,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
