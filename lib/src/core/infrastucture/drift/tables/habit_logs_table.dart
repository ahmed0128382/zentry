import 'package:drift/drift.dart';
import 'habits_table.dart';

@DataClassName('HabitLogRow')
class HabitLogsTable extends Table {
  TextColumn get id => text()();

  TextColumn get habitId => text().customConstraint(
      'NOT NULL REFERENCES habits_table(id) ON DELETE CASCADE')();

  /// store date as UTC midnight (date-only)
  DateTimeColumn get date => dateTime()();

  /// log status as string (use your enum names)
  TextColumn get status => text()();

  /// optional numeric amount for "reachAmount" goals
  IntColumn get amount => integer().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();

  @override
  Set<Column> get primaryKey => {id};
}
