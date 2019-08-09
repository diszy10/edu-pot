import 'package:moor_flutter/moor_flutter.dart';

import 'package:edukasi_pot/models/models.dart';

part 'subject.g.dart';

@UseDao(tables: [Subjects])
class SubjectsDao extends DatabaseAccessor<AppDatabase>
    with _$SubjectsDaoMixin {
  SubjectsDao(AppDatabase db) : super(db);

  Future<List<Subject>> listAllSortByTime() async {
    return (select(subjects)
          ..orderBy([(t) => OrderingTerm(expression: t.startTime)]))
        .get();
  }

  Future<List<Subject>> listByIds(List<int> ids) async {
    List<Variable> idsVar = [];
    String idsIn = ids.map((id) {
      idsVar.add(Variable.withInt(id));
      return '?';
    }).join(', ');
    final select = await customSelect(
        'SELECT * FROM subjects WHERE id IN ($idsIn);',
        variables: idsVar);
    return select.map((row) => Subject.fromData(row.data, db)).toList();
  }

  Future<void> saveList(List<Subject> subjectList) async {
    return into(subjects).insertAll(subjectList, orReplace: true);
  }

  Future<int> deleteAll() async {
    return delete(subjects).go();
  }
}
