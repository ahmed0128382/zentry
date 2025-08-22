// lib/src/core/infrastucture/drift/tables/sections_table.dart
import 'package:drift/drift.dart';

@DataClassName('SectionRow')
class SectionsTable extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get type => text()(); // e.g. SectionType.name
  IntColumn get orderIndex => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
