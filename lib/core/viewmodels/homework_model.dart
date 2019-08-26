import 'package:edukasi_pot/core/enums/viewstate.dart';
import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/core/services/homework_service.dart';
import 'package:edukasi_pot/core/viewmodels/base_model.dart';
import 'package:edukasi_pot/locator.dart';

class HomeworkModel extends BaseModel {
  HomeworkService _homeworksService = locator<HomeworkService>();

  List<Homework> get homeworks => _homeworksService.homeworks;

  Future getHomeworksForSubject(String subjectId) async {
    setState(ViewState.Busy);
    await _homeworksService.getHomeworks(subjectId);
    setState(ViewState.Idle);
  }

  void setDistribute(String homeworkId) {
    _homeworksService.setDistribute(homeworkId);
    notifyListeners();
  }

  void unDistribute(String homeworkId) {
    _homeworksService.unDistribute(homeworkId);
    notifyListeners();
  }
}
