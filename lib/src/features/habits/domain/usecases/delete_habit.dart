import 'package:zentry/src/shared/domain/errors/result.dart';
import '../../../../shared/domain/repos/habits_repo.dart';

class DeleteHabit {
  final HabitsRepo repo;
  const DeleteHabit(this.repo);

  Future<Result<void>> call(String habitId) => repo.delete(habitId);
}
