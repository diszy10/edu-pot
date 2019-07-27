import 'package:dio/dio.dart';
import 'package:edukasi_pot/providers/providers.dart';
import './auth.dart';

class MockAdapter extends HttpClientAdapter {

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<List<int>> requestStream, Future cancelFuture) async {
    Uri uri = options.uri;
    switch (uri.path) {
      case Auth.loginPath:
        return login(options);
      case SubjectList.subjectListPath:
        break;
      default:
        return ResponseBody.fromString('', 404, headers: DioHttpHeaders());
    }
  }
}
