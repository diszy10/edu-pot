import 'dart:async';

import 'package:edukasi_pot/core/services/api/api.dart';
import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/locator.dart';

class HomeworkService {
  Api _api = locator<Api>();

  List<Homework> _homeworks;
  List<Homework> get homeworks => _homeworks;

  Future getHomeworks(String subjectId) async {
    _homeworks = await _api.getHomeworksForSubject(subjectId);
  }

  void setDeadline(String homeworkId, DateTime deadlineDate) {
    _homeworks.firstWhere((homework) => homework.id == homeworkId).deadline =
        deadlineDate;
  }

  void resetDeadline(String homeworkId) {
    _homeworks.firstWhere((homework) => homework.id == homeworkId).deadline =
        null;
  }

  void setDistribute(String homeworkId) {
    _homeworks
        .firstWhere((homework) => homework.id == homeworkId)
        .isDistribute = true;
  }

  void unDistribute(String homeworkId) {
    _homeworks
        .firstWhere((homework) => homework.id == homeworkId)
        .isDistribute = false;
  }
}
