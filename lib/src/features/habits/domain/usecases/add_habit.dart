import 'package:dartz/dartz.dart';
import '../entities/habit.dart';
import '../repos/habits_repo.dart';

class AddHabit {
  final HabitsRepo repo;
  const AddHabit(this.repo);

  Future<Either<Exception, Habit>> call(Habit habit) => repo.create(habit);
}
