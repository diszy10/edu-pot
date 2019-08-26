import 'package:edukasi_pot/core/services/api/api.dart';
import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/locator.dart';

class ModuleService {
  Api _api = locator<Api>();

  List<Module> _module;
  List<Module> get modules => _module;

  Future getModules(String subjectId) async {
    _module = await _api.getModulesForSubject(subjectId);
  }
}
