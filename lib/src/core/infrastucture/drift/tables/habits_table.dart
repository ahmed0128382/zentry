import 'package:drift/drift.dart';

class HabitsTable extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();

  TextColumn get sectionId => text()(); // FK -> SectionsTable.id

  TextColumn get status => text()(); // HabitStatus.name
  TextColumn get frequency => text()(); // HabitFrequency.name

  IntColumn get weeklyDaysMask => integer().nullable()(); // 7-bit 0..127
  IntColumn get intervalDays => integer().nullable()(); // every N days

  // Goal
  TextColumn get goalType => text()(); // GoalType.name
  TextColumn get goalUnit => text()(); // HabitGoalUnit.name
  TextColumn get goalPeriod => text()(); // HabitGoalPeriod.name
  TextColumn get goalRecordMode => text()(); // HabitGoalRecordMode.name
  IntColumn get targetAmount => integer().nullable()();
  DateTimeColumn get goalStartDate => dateTime().nullable()();
  DateTimeColumn get goalEndDate => dateTime().nullable()();

  // Behavior flags
  BoolColumn get autoPopup => boolean().withDefault(const Constant(true))();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
