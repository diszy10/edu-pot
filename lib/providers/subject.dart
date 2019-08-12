import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import 'package:edukasi_pot/helpers/helpers.dart';
import 'package:edukasi_pot/models/models.dart';

class SubjectProvider
    with SubjectService, UserToken, ChangeNotifier {

  final AppDatabase _db;
  final Api _api;

  SubjectProvider(this._db, this._api);

  List<Subject> _subjectList = [];

  Future<List<Subject>> get subjectList async {
    List<Subject> serverList = await _getSubjects();
    await _db.subjectsDao.saveList(serverList);
    _subjectList = await _db.subjectsDao.listAllSortByTime();

    notifyListeners();
    return _subjectList;
  }

  Future<Subject> get subjectInSession async {
    var _list = await subjectList;
    // var now = DateTime.now();
    var now = DateTime.parse('2019-07-30T13:25:00Z').toLocal(); // For Testing;
    Subject _subject;

    for (var sub in _list) {
      if (sub.startTime.isBefore(now) && sub.endTime.isAfter(now)) {
        _subject = sub;
        break;
      }
    }

    return _subject;
  }

  Future<void> onLogout() async {
    await _db.subjectsDao.deleteAll();
  }
}

mixin SubjectService implements UserToken {
  Api _api;

  static const subjectListPath = '/subject-list';

  Future<List<Subject>> _getSubjects() async {
    String token = await getToken();
    _api.dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options options) async {
      options.headers['token'] = token;
      return options;
    }));
    Response response = await _api.dio.get(subjectListPath);
    List maps = response.data['data'];
    return maps.map((e) => Subject.fromJson(e, serializer: UtcSerializer())).toList();
  }
}
