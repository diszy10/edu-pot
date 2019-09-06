import 'package:edukasi_pot/core/constants/route_paths.dart' as routes;
import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/core/services/module_service.dart';
import 'package:edukasi_pot/core/services/navigation_service.dart';
import 'package:edukasi_pot/core/viewmodels/base_model.dart';
import 'package:edukasi_pot/locator.dart';

class ModuleModel extends BaseModel {
  NavigationService _navigationService = locator<NavigationService>();

  ModuleService _modulesService = locator<ModuleService>();

  List<Module> get modules => _modulesService.modules;

  Future getModules(String subjectId) async {
    await _modulesService.getModules(subjectId);
  }

  void navigateToModuleDetail({dynamic arguments}) {
    _navigationService.navigateToReplacement(routes.ModuleDetail,
        arguments: arguments);
  }

  void navigateToHomework() {
    _navigationService.navigateToReplacement(routes.Homework);
  }

  void hideDrawer() {
    _navigationService.navigateBack();
  }

  int get moduleIndex => _modulesService.moduleIndex;

  void setActiveModule(int index) {
    _modulesService.setActiveModule(index);
  }
}
