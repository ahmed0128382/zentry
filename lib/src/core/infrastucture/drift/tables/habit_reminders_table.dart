import 'package:drift/drift.dart';
import 'habits_table.dart';

class HabitRemindersTable extends Table {
  TextColumn get id => text()(); // UUID

  TextColumn get habitId => text().customConstraint(
      'NOT NULL REFERENCES habits_table(id) ON DELETE CASCADE')();

  IntColumn get minutesSinceMidnight => integer()(); // 0..1439
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}
