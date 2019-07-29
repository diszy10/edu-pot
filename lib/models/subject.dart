import 'package:edukasi_pot/models/data/data.dart';

class Subject {
  final int id;
  final int idServer;
  final String name;
  final String klass;
  final DateTime startTime;
  final DateTime endTime;

  Subject(
      {this.id,
      this.idServer,
      this.name,
      this.klass,
      this.startTime,
      this.endTime});


  // Serialization
  static const keyIdServer = 'id';
  static const keyName = 'name';
  static const keyKlass = 'klass';
  static const keyStartTime = 'startTime';
  static const keyEndTime = 'endTime';

  factory Subject.fromJson(Map<String, dynamic> json) {
    var jsonStart = json[keyStartTime];
    var jsonEnd = json[keyEndTime];

    return Subject(
      idServer: json[keyIdServer] as int,
      name: json[keyName] as String,
      klass: json[keyKlass] as String,
      startTime: jsonStart == null ? null : DateTime.parse(jsonStart as String),
      endTime: jsonEnd == null ? null : DateTime.parse(jsonEnd as String),
    );
  }

  factory Subject.fromData(Map<String, dynamic> data) {
    var dataStart = data[SubjectData.colStartTime];
    var dataEnd = data[SubjectData.colStartTime];

    return Subject(
      id: data[SubjectData.colId] as int,
      idServer: data[SubjectData.colIdServer] as int,
      name: data[SubjectData.colName] as String,
      klass: data[SubjectData.colKlass] as String,
      startTime: dataStart == null ? null : DateTime.parse(dataStart as String),
      endTime: dataEnd == null ? null : DateTime.parse(dataEnd as String),
    );
  }

  Map<String, dynamic> toData() {
    return <String, dynamic>{
      SubjectData.colId: this.id,
      SubjectData.colIdServer: this.idServer,
      SubjectData.colName: this.name,
      SubjectData.colKlass: this.klass,
      SubjectData.colStartTime: this.startTime?.toIso8601String(),
      SubjectData.colEndTime: this.endTime?.toIso8601String()
    };
  }
}

