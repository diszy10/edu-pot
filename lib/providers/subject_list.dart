import 'package:edukasi_pot/models/models.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:edukasi_pot/helpers/helpers.dart';
import 'package:edukasi_pot/models/models.dart';

class SubjectListProvider
    with SubjectListPersist, SubjectListService, UserToken, ChangeNotifier {

  final AppDatabase _db;
  final Api _api;

  SubjectListProvider(this._db, this._api);

  List<Subject> _subjectList = [];

  Future<List<Subject>> get subjectList async {
    List<int> ids = await _getIds();
    if (ids != null && ids.length > 0) {
      _subjectList = await _db.subjectsDao.listByIds(ids);
    } else {
      List<Subject> serverList = await _getSubjects();
      await _db.subjectsDao.saveList(serverList);
      await _setIds(serverList.map((sub) => sub.id).toList());
      _subjectList = serverList;
    }
    notifyListeners();
    return _subjectList;
  }

  Future<void> onLogout() async {
    await _delListPrefs();
    await _db.subjectsDao.deleteAll();
  }
}

mixin SubjectListService implements UserToken {
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

mixin SubjectListPersist {
  String _listPrefsKey = 'subjectListIds';

  /// Get ID server from shared preferences
  Future<List<int>> _getIds() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> stringList = prefs.getStringList(_listPrefsKey);
    if (stringList == null) {
      return [];
    }
    List<int> ids = stringList.map((e) => int.tryParse(e)).toList();
    return ids..removeWhere((e) => e == null);
  }

  /// Set ID server to shared preferences
  Future<bool> _setIds(List<int> ids) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> strIds = ids.map((e) => e.toString()).toList();
    return prefs.setStringList(_listPrefsKey, strIds);
  }

  /// Delete Preference Key and Value
  Future<bool> _delListPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_listPrefsKey, null);
    return prefs.remove(_listPrefsKey);
  }
}
