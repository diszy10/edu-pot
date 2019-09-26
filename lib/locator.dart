import 'package:edukasi_pot/core/services/api/api.dart';
import 'package:edukasi_pot/core/services/api/mock_api.dart';
import 'package:edukasi_pot/core/services/api/http_api.dart';
import 'package:edukasi_pot/core/services/services.dart';
import 'package:edukasi_pot/core/viewmodels/viewmodels.dart';
import 'package:get_it/get_it.dart';

const bool USE_MOCK_IMPLEMENTATION = true;

GetIt locator = GetIt.I;

Future<void> setupLocator() async {
  var instance = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(instance);
  locator.registerLazySingleton(() => ConnectivityService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton<Api>(
      () => USE_MOCK_IMPLEMENTATION ? MockApi() : HttpApi());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => SubjectService());
  locator.registerLazySingleton(() => ModuleService());
  locator.registerLazySingleton(() => HomeworkService());
  locator.registerLazySingleton(() => AttendanceService());

  locator.registerFactory(() => AuthModel());
  locator.registerFactory(() => SubjectModel());
  locator.registerFactory(() => ModuleModel());
  locator.registerFactory(() => HomeworkModel());
  locator.registerFactory(() => AttendanceModel());
  locator.registerFactory(() => AddNoteModel());
}
