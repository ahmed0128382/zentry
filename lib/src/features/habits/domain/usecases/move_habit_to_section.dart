import 'package:zentry/src/shared/domain/errors/result.dart';
import '../../../../shared/domain/repos/habits_repo.dart';

class MoveHabitToSection {
  final HabitsRepo repo;
  const MoveHabitToSection(this.repo);

  Future<Result<void>> call({
    required String habitId,
    required String newSectionId,
    required int newOrderIndex,
  }) {
    return repo.moveToSection(
      habitId: habitId,
      newSectionId: newSectionId,
      newOrderIndex: newOrderIndex,
    );
  }
}
