import 'package:edukasi_pot/core/constants/route_paths.dart' as routes;
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

  Future getSubjects(String userId) async {
    await _subjectsService.getSubjects(userId);
  }

  Future getModules(String subjectId) async {
    await _modulesService.getModules(subjectId);
    navigateToModuleDetail();
  }

  void addSubjectToStream(Subject subject) {
    _subjectsService.addSubjectToStream(subject);
  }

  void navigateToSubjectDetail({dynamic arguments}) {
    _navigationService.navigateToReplacement(routes.SubjectDetail,
        arguments: arguments);
  }

  void navigateToModuleDetail() {
    _navigationService.navigateToReplacement(routes.ModuleDetail,
        arguments: _modulesService.modules[0]);
  }
}
