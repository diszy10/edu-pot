import 'dart:async';

import 'package:edukasi_pot/core/services/api/api.dart';
import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/locator.dart';

class SubjectService {
  Api _api = locator<Api>();

  StreamController<Subject> subjectController = StreamController<Subject>();

  List<Subject> _subjects;
  List<Subject> get subjects => _subjects;

  Subject _subjectInSession;
  Subject get subjectInSession => _subjectInSession;

  Future getSubjects(String userId) async {
    _subjects = await _api.getSubjectsForUser(userId);
  }

  Future getSubjectInSession() async {
    DateTime now = DateTime.parse('2019-07-30T07:45:00Z').toLocal();

    for (var subject in _subjects) {
      if (subject.startTime.isBefore(now) && subject.endTime.isAfter(now)) {
        _subjectInSession = subject;
        break;
      }
    }
  }

  void addSubjectToStream(Subject subject) {
    subjectController.add(subject);
  }

  void clearSubjectInSession() {
    _subjectInSession = null;
  }
}
