import 'package:flutter/material.dart';

class User {
  int id;
  String name, imageUrl;

  User({this.id, this.name, this.imageUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}

class Subject {
  int id;
  String title, klass;
  DateTime startTime, endTime;

  Subject({this.id, this.title, this.klass, this.startTime, this.endTime});
}

class Module {
  final String id, title;

  Module({this.id, this.title});
}

class Exercise {
  final String title, content;

  Exercise({this.title, this.content});
}

class Homework with ChangeNotifier {
  int id;
  String title;
  DateTime deadline;
  bool isDistribute;
  Color color;

  Homework(
      {this.id,
      this.title,
      this.deadline,
      this.color,
      this.isDistribute = false});
}

class Student with ChangeNotifier {
  int id;
  String name, imageUrl;
  bool isAbsent;

  Student({this.id, this.name, this.imageUrl, this.isAbsent = false});
}

class NoteSession {
  String id, subjectId, notes;
  DateTime timestamp;

  NoteSession({this.id, this.subjectId, this.timestamp, this.notes});
}
