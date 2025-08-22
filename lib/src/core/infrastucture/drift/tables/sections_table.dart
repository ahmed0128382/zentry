import 'package:drift/drift.dart';

class SectionsTable extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get type => text()(); // SectionType.name
  IntColumn get orderIndex => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
