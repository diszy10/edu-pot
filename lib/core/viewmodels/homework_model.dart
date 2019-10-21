import 'package:edukasi_pot/core/constants/route_paths.dart' as routes;
import 'package:edukasi_pot/core/enums/viewstate.dart';
import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/core/services/homework_service.dart';
import 'package:edukasi_pot/core/services/navigation_service.dart';
import 'package:edukasi_pot/core/viewmodels/base_model.dart';
import 'package:edukasi_pot/locator.dart';
import 'package:flutter/material.dart';

class HomeworkModel extends BaseModel {
  NavigationService _navigationService = locator<NavigationService>();

  HomeworkService _homeworksService = locator<HomeworkService>();

  List<Homework> get homeworks => _homeworksService.homeworks;

  Future<void> getHomeworksForSubject(int subjectId) async {
    setState(ViewState.Busy);
    await _homeworksService.getHomeworks(subjectId);
    setState(ViewState.Idle);
  }

  void setDeadline(int homeworkId, DateTime deadlineDate) {
    _homeworksService.setDeadline(homeworkId, deadlineDate);
    notifyListeners();
  }

  void setDistribute(int homeworkId) {
    _homeworksService.setDistribute(homeworkId);
    notifyListeners();
  }

  void setColor(int homeworkId, Color selectedColor) {
    _homeworksService.setColor(homeworkId, selectedColor);
    notifyListeners();
  }

  void unDistribute(int homeworkId) {
    _homeworksService.unDistribute(homeworkId);
    _homeworksService.resetDeadline(homeworkId);
    notifyListeners();
  }

  void navigateToAttendance() {
    _navigationService.navigateTo(routes.Attendance);
  }
}
