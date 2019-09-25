import 'package:flutter/material.dart';

class User {
  String id, name, imageUrl;

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
  final String id, title, klass;
  final DateTime startTime, endTime;

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

class Homework {
  String id, title;
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

class Student {
  final String id, name, imageUrl;
  bool isAbsent;

  Student({this.id, this.name, this.imageUrl, this.isAbsent = false});
}

class NoteSession {
  String id, subjectId, notes;
  DateTime timestamp;

  NoteSession({this.id, this.subjectId, this.timestamp, this.notes});
}
