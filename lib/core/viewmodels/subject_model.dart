import 'package:edukasi_pot/core/constants/route_paths.dart' as routes;
import 'package:edukasi_pot/core/enums/viewstate.dart';
import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/core/services/module_service.dart';
import 'package:edukasi_pot/core/services/navigation_service.dart';
import 'package:edukasi_pot/core/services/subject_service.dart';
import 'package:edukasi_pot/core/viewmodels/base_model.dart';
import 'package:edukasi_pot/locator.dart';

class SubjectModel extends BaseModel {
  NavigationService _navigationService = locator<NavigationService>();

  SubjectService _subjectsService = locator<SubjectService>();
  ModuleService _modulesService = locator<ModuleService>();

  List<Subject> get subjects => _subjectsService.subjects;
  Subject get subjectInSession => _subjectsService.subjectInSession;

  Future<void> getSubjects(int userId) async {
    await _subjectsService.getSubjects(userId);
  }

  Future<void> getSubjectInSession() async {
    await _subjectsService.getSubjectInSession();
  }

  Future<void> getModules(int subjectId) async {
    setState(ViewState.Busy);
    await _modulesService.getModules(subjectId);

    navigateToModuleDetail();
    setState(ViewState.Idle);
  }

  void addSubjectToStream(Subject subject) {
    _subjectsService.addSubjectToStream(subject);
  }

  void navigateToSubjectDetail({dynamic arguments}) {
    _navigationService.navigateToReplacement(routes.SubjectDetail,
        arguments: arguments);
  }

  void navigateToSubjectList({dynamic arguments}) async {
    _navigationService.navigateToReplacement(routes.SubjectList,
        arguments: arguments);
  }

  void navigateToModuleDetail() {
    _navigationService.navigateToReplacement(routes.ModuleDetail,
        arguments: _modulesService.modules[0]);
  }
}
