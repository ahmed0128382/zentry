import 'section.dart';

import 'habit_details.dart';

class SectionWithHabits {
  final Section section;
  final List<HabitDetails> habits;

  const SectionWithHabits({
    required this.section,
    required this.habits,
  });
}
