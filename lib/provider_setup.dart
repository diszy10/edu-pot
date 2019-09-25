import 'package:edukasi_pot/core/services/api/api.dart';
import 'package:edukasi_pot/core/services/api/http_api.dart';
import 'package:edukasi_pot/core/services/api/mock_api.dart';
import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/core/services/services.dart';
import 'package:edukasi_pot/locator.dart';
import 'package:provider/provider.dart';

const bool USE_MOCK_IMPLEMENTATION = true;

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...uiConsumableProviders
];

List<SingleChildCloneableWidget> independentServices = [
  Provider<Api>.value(value: USE_MOCK_IMPLEMENTATION ? MockApi() : HttpApi()),
];

List<SingleChildCloneableWidget> uiConsumableProviders = [
  StreamProvider<ConnectivityStatus>.controller(
      builder: (context) =>
          locator<ConnectivityService>().connectionStatusController),
  StreamProvider<User>.controller(
      builder: (context) => locator<AuthService>().userController),
  StreamProvider<Subject>.controller(
      builder: (context) => locator<SubjectService>().subjectController)
];
