import 'package:dartz/dartz.dart';
import '../../../../shared/domain/entities/habit.dart';
import '../../../../shared/domain/repos/habits_repo.dart';

class AddHabit {
  final HabitsRepo repo;
  const AddHabit(this.repo);

  Future<Either<Exception, Habit>> call(Habit habit) => repo.create(habit);
}
