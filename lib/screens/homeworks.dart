import 'dart:math';

import 'package:edukasi_pot/providers/homework.dart';
import 'package:edukasi_pot/providers/homeworks.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens.dart';

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
                SizedBox(height: 50.0),
                _HeaderNav(),
                SizedBox(height: 50.0),
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
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Based on your teaching session',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFFA29C9D),
                ),
              )
            ],
          ),
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16.0),
            child: InkWell(
              onTap: () => Navigator.pushReplacementNamed(
                  context, SubjectScreen.routeName),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFDBE7F9),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xFF5771AD),
                      fontWeight: FontWeight.bold),
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: colors[random.nextInt(6)],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => showDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) => HomeworkModal(),
          ),
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            padding: EdgeInsets.all(32.0),
            child: Center(
              child: Text(
                homework.title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 18.0),
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
                  'Ini modal',
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
                        onTap: () {},
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
                        onTap: () {},
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
                                    fontWeight: FontWeight.bold),
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
