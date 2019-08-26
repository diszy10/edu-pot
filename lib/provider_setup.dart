import 'package:edukasi_pot/core/services/api/api.dart';
import 'package:edukasi_pot/core/services/api/http_api.dart';
import 'package:edukasi_pot/core/services/api/mock_api.dart';
import 'package:provider/provider.dart';

const bool USE_MOCK_IMPLEMENTATION = true;

List<SingleChildCloneableWidget> providers = [
  Provider<Api>.value(value: USE_MOCK_IMPLEMENTATION ? MockApi() : HttpApi()),
];
