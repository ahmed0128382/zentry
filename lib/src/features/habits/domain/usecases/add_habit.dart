import 'package:zentry/src/shared/domain/errors/result.dart';
import '../../../../shared/domain/entities/habit.dart';
import '../../../../shared/domain/repos/habits_repo.dart';

class AddHabit {
  final HabitsRepo repo;
  const AddHabit(this.repo);

  Future<Result<Habit>> call(Habit habit) => repo.create(habit);
}
