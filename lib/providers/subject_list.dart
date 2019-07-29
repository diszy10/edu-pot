import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'package:edukasi_pot/helpers/helpers.dart';
import 'package:edukasi_pot/models/data/data.dart';
import 'package:edukasi_pot/models/models.dart';

class SubjectListProvider
    with SubjectListPersist, SubjectListService, UserToken, ChangeNotifier {
  List<Subject> _subjectList = [];

  Future<List<Subject>> get subjectList async {
    List<int> ids = await _getIds();
    if (ids != null && ids.length > 0) {
      _subjectList = await _subjectListByIds(ids);
    } else {
      List<Subject> serverList = await _getSubjects();
      ids = await _saveSubjects(serverList);
      await _setIds(ids);
      _subjectList = await _subjectListByIds(ids);
    }
    notifyListeners();
    return _subjectList;
  }

  Future<void> onLogout() async {
    await _delListPrefs();
    await _deleteSubjects();
  }
}

mixin SubjectListService implements UserToken {
  static const subjectListPath = '/subject-list';
  final Dio _dio = Api().dio;

  Future<List<Subject>> _getSubjects() async {
    String token = await getToken();
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options options) async {
      options.headers['token'] = token;
      return options;
    }));
    Response response = await _dio.get(subjectListPath);
    List maps = response.data['data'];
    return maps.map((e) => Subject.fromJson(e)).toList();
  }
}

mixin SubjectListPersist {
  // Database
  Future<Database> get _db => AppDatabase().db;

  Future<List<Subject>> _subjectListByIds(List<int> ids) async {
    Database db = await _db;

    // Generate (?, ?, ...?) depending on ids size.
    String idsQuery = ids.map((_)=> '?').join(', ');
    List<Map<String, dynamic>> maps = await db.query(SubjectData.tableName,
        where: '${SubjectData.colId} IN ($idsQuery)',
        whereArgs: ids,
        orderBy: '${SubjectData.colStartTime} ASC');
    return maps.map((e) => Subject.fromData(e)).toList();
  }

  /// Save subjects and return list of saved ids.
  Future<List<int>> _saveSubjects(List<Subject> subjects) async {
    Database db = await _db;

    Batch batch = db.batch();
    for (var subject in subjects) {
      batch.insert(SubjectData.tableName, subject.toData(),);
    }
    var results = await batch.commit();
    return List<int>.from(results);
  }

  Future<int> _deleteSubjects() async {
    Database db = await _db;
    return db.delete(SubjectData.tableName, where: null);
  }

  // Preference
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

  Future<bool> _delListPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_listPrefsKey, null);
    return prefs.remove(_listPrefsKey);
  }
}
