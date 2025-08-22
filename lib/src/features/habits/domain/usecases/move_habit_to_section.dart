import 'package:dartz/dartz.dart';
import '../repos/habits_repo.dart';

class MoveHabitToSection {
  final HabitsRepo repo;
  const MoveHabitToSection(this.repo);

  Future<Either<Exception, void>> call({
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
