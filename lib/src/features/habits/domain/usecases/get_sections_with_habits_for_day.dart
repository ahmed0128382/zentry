// File: lib/src/features/habits/domain/usecases/get_sections_with_habits_for_day.dart

import 'package:zentry/src/features/habits/domain/entities/section_with_habits.dart';

import 'package:zentry/src/shared/domain/errors/result.dart';
import 'package:zentry/src/shared/domain/repos/habits_repo.dart';

class GetSectionsWithHabitsForDay {
  final HabitsRepo repo;
  GetSectionsWithHabitsForDay(this.repo);

  Stream<Result<List<SectionWithHabits>>> call(DateTime day) {
    return repo.watchSectionsWithHabitsForDay(day);
  }
}
