import 'package:dio/dio.dart';
import 'package:edukasi_pot/providers/providers.dart';

import 'package:edukasi_pot/mocks/api/auth.dart';
import 'package:edukasi_pot/mocks/api/subject_list.dart';

class MockAdapter extends HttpClientAdapter {

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<List<int>> requestStream, Future cancelFuture) async {
    Uri uri = options.uri;
    switch (uri.path) {
      case AuthService.loginPath:
        return await login(options);
      case SubjectService.subjectListPath:
        return await subjectList(options);
      default:
        return ResponseBody.fromString('', 404, headers: DioHttpHeaders());
    }
  }
}
