import 'package:drift/drift.dart';

class HabitLogsTable extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get habitId => text()(); // FK -> HabitsTable.id

  /// Store only date part (UTC midnight) for easy queries
  DateTimeColumn get date => dateTime()();

  /// For now we reuse HabitStatus.name as you started; can split later.
  TextColumn get status => text()();

  /// Optional: if you later support partial amounts (e.g., 2/3 cups)
  IntColumn get amount => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
