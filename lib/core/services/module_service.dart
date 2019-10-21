import 'package:edukasi_pot/core/data/repository.dart';
import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/core/services/stoppable_service.dart';
import 'package:edukasi_pot/locator.dart';

class ModuleService implements StoppableService {
  Repository _repo = locator<Repository>();

  List<Module> _modules;
  List<Module> get modules => _modules;

  Future getModules(int subjectId) async {
    _modules = await _repo.getModules(subjectId);
  }

  int _selectedModule = 1;
  int get moduleIndex => _selectedModule;

  void setActiveModule(int index) {
    _selectedModule = index;
  }

  @override
  bool get serviceStopped => null;

  @override
  void start() {}

  @override
  void stop() {}
}
