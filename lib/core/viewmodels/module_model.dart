import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/core/services/module_service.dart';
import 'package:edukasi_pot/core/viewmodels/base_model.dart';
import 'package:edukasi_pot/locator.dart';

class ModuleModel extends BaseModel {
  ModuleService _modulesService = locator<ModuleService>();

  List<Module> get modules => _modulesService.modules;

  Future getModules(String subjectId) async {
    await _modulesService.getModules(subjectId);
  }
}
