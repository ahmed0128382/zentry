import 'package:dartz/dartz.dart';
import '../entities/habit_reminder.dart';

abstract class HabitRemindersRepo {
  Future<Either<Exception, List<HabitReminder>>> getForHabit(String habitId);
  Future<Either<Exception, HabitReminder>> add(HabitReminder reminder);
  Future<Either<Exception, HabitReminder>> update(HabitReminder reminder);
  Future<Either<Exception, void>> delete(String reminderId);
}
