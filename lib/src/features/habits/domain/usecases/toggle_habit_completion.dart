import 'package:zentry/src/features/habits/domain/enums/habit_status.dart';
import 'package:zentry/src/shared/domain/entities/habit.dart';
import 'package:zentry/src/shared/domain/errors/result.dart';
import 'package:zentry/src/shared/domain/repos/habits_repo.dart';

class ToggleHabitCompletion {
  final HabitsRepo repo;

  const ToggleHabitCompletion(this.repo);

  Future<Result<Habit>> call(Habit habit) async {
    final newStatus = habit.status == HabitStatus.completed
        ? HabitStatus.active // رجّعه Active لو كان Completed
        : HabitStatus.completed; // أو كمّله لو مش Completed

    final updated = habit.copyWith(status: newStatus);
    return repo.update(updated);
  }
}
