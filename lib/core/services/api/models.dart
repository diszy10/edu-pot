class User {
  final String id, name, imageUrl;

  User({this.id, this.name, this.imageUrl});
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
  final String id, title;
  DateTime deadline;
  bool isDistribute;

  Homework({this.id, this.title, this.deadline, this.isDistribute = false});
}

class Student {
  final String id, name, imageUrl;
  bool isAbsent;

  Student({this.id, this.name, this.imageUrl, this.isAbsent = false});
}
