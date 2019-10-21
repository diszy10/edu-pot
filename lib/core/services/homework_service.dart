import 'dart:async';

import 'package:edukasi_pot/core/data/repository.dart';
import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/core/services/stoppable_service.dart';
import 'package:edukasi_pot/locator.dart';
import 'package:flutter/material.dart';

class HomeworkService implements StoppableService {
  Repository _repo = locator<Repository>();

  List<Homework> _homeworks;
  List<Homework> get homeworks => _homeworks;

  Future getHomeworks(int subjectId) async {
    _homeworks = await _repo.getHomeworks(subjectId);
  }

  void setDeadline(int homeworkId, DateTime deadlineDate) {
    _homeworks.firstWhere((homework) => homework.id == homeworkId).deadline =
        deadlineDate;
  }

  void resetDeadline(int homeworkId) {
    _homeworks.firstWhere((homework) => homework.id == homeworkId).deadline =
        null;
  }

  void setColor(int homeworkId, Color color) {
    _homeworks.firstWhere((homework) => homework.id == homeworkId).color =
        color;
  }

  void setDistribute(int homeworkId) {
    _homeworks
        .firstWhere((homework) => homework.id == homeworkId)
        .isDistribute = true;
  }

  void unDistribute(int homeworkId) {
    _homeworks
        .firstWhere((homework) => homework.id == homeworkId)
        .isDistribute = false;
  }

  @override
  bool get serviceStopped => null;

  @override
  void start() {}

  @override
  void stop() {}
}
