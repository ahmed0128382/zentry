import 'package:dartz/dartz.dart';
import '../../../../shared/domain/entities/habit.dart';
import '../../../../shared/domain/repos/habits_repo.dart';

class UpdateHabit {
  final HabitsRepo repo;
  const UpdateHabit(this.repo);

  Future<Either<Exception, Habit>> call(Habit habit) => repo.update(habit);
}
