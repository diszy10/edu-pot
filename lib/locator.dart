import 'package:edukasi_pot/core/services/api/api.dart';
import 'package:edukasi_pot/core/services/api/mock_api.dart';
import 'package:edukasi_pot/core/services/api/http_api.dart';
import 'package:edukasi_pot/core/services/services.dart';
import 'package:edukasi_pot/core/viewmodels/viewmodels.dart';
import 'package:get_it/get_it.dart';

const bool USE_MOCK_IMPLEMENTATION = true;

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton<Api>(
      () => USE_MOCK_IMPLEMENTATION ? MockApi() : HttpApi());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => SubjectService());
  locator.registerLazySingleton(() => ModuleService());
  locator.registerLazySingleton(() => HomeworkService());
  locator.registerLazySingleton(() => AttendanceService());

  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => SubjectModel());
  locator.registerFactory(() => ModuleModel());
  locator.registerFactory(() => HomeworkModel());
  locator.registerFactory(() => AttendanceModel());
}
