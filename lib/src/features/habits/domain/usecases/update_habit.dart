import 'package:dartz/dartz.dart';
import '../entities/habit.dart';
import '../repos/habits_repo.dart';

class UpdateHabit {
  final HabitsRepo repo;
  const UpdateHabit(this.repo);

  Future<Either<Exception, Habit>> call(Habit habit) => repo.update(habit);
}
