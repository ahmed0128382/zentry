import 'package:dartz/dartz.dart';
import '../../../../shared/domain/repos/habits_repo.dart';

class DeleteHabit {
  final HabitsRepo repo;
  const DeleteHabit(this.repo);

  Future<Either<Exception, void>> call(String habitId) => repo.delete(habitId);
}
