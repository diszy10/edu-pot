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
    if (_subjectList.length > 0) return _subjectList;

    List<int> ids = await _getIds();
    if (ids.length > 0) {
      _subjectList = await _subjectListByIds(ids);
    } else {
      _subjectList = await _getSubjects();
    }
    notifyListeners();
    return _subjectList;
  }

}

mixin SubjectListService implements UserToken {
  static const subjectListPath = '/subject-list';
  final Dio _dio = Api().dio;

  Future<List<Subject>> _getSubjects() async {
    String token = await getToken();
    Response response = await _dio
        .post(subjectListPath);
    return response.data['data'];
  }
}

mixin SubjectListPersist {
  // Database
  Future<Database> get _db => AppDatabase().db;

  Future<List<Subject>> _subjectListByIds(List<int> ids) async {
    Database db = await _db;

    List<Map<String, dynamic>> maps = await db.query(SubjectData.tableName,
        where: '${SubjectData.colId} IN ?',
        whereArgs: ids,
        orderBy: '${SubjectData.colStartTime} ASC');
    return maps.map((e) => Subject.fromData(e)).toList();
  }

  // Preference
  String _listPrefsKey = 'subjectListIds';

  /// Get ID server from shared preferences
  Future<List<int>> _getIds() async {
    final prefs = await SharedPreferences.getInstance();
    List<int> ids =
        prefs.getStringList(_listPrefsKey).map((e) => int.tryParse(e)).toList();
    return ids..removeWhere((e) => e == null);
  }

  /// Set ID server to shared preferences
  Future<bool> _setIds(List<Subject> subjectList) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> ids = subjectList.map((e) => e.id.toString()).toList();
    return prefs.setStringList(_listPrefsKey, ids);
  }
}
