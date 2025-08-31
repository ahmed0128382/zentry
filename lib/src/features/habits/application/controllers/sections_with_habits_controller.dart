// File: src/features/habits/application/controllers/sections_with_habits_controller.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/habits/application/controllers/habits_controller.dart';
import 'package:zentry/src/features/habits/application/providers/habits_controller_provider.dart';
import 'package:zentry/src/features/habits/application/states/sections_with_habits_state.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_details.dart';
import 'package:zentry/src/features/habits/domain/entities/section.dart';
import 'package:zentry/src/features/habits/domain/entities/section_with_habits.dart';
import 'package:zentry/src/features/habits/domain/enums/section_type.dart';
import 'package:zentry/src/features/habits/domain/usecases/get_sections_with_habits_for_day.dart';
import 'package:zentry/src/shared/domain/entities/habit.dart';

class SectionsWithHabitsController
    extends StateNotifier<SectionsWithHabitsState> {
  final GetSectionsWithHabitsForDay getSectionsWithHabitsForDay;
  final Ref ref;
  DateTime currentDay = DateTime.now();

  late final ProviderSubscription _habitsSubscription;

  SectionsWithHabitsController({
    required this.getSectionsWithHabitsForDay,
    required this.ref,
  }) : super(SectionsWithHabitsState(sections: [])) {
    // Listen to habits changes
    _habitsSubscription = ref.listen<HabitsState>(
      habitsControllerProvider,
      (previous, next) {
        watchSections(currentDay);
      },
      fireImmediately: true,
    );
  }

  /// Fetch and organize sections with habits for a given day
  void watchSections(DateTime day) {
    currentDay = day;

    final habitsState = ref.read(habitsControllerProvider);
    final habits = habitsState.habits;

    // ✅ Filter out habits not scheduled for this day (TickTick style)
    final scheduledHabits = habits.where((hd) {
      return hd.habit.isScheduledForDay(day);
    }).toList();

    // Group habits by section
    final Map<String, List<HabitDetails>> sectionsMap = {};
    for (final hd in scheduledHabits) {
      final key = hd.habit.sectionId ?? 'anytime';
      sectionsMap.putIfAbsent(key, () => []).add(hd);
    }

    // Build SectionWithHabits list
    final List<SectionWithHabits> organizedSections = sectionsMap.entries
        .map((entry) {
          final sectionType = sectionIds.entries
              .firstWhere(
                (e) => e.value == entry.key,
                orElse: () => MapEntry(SectionType.anytime, 'anytime'),
              )
              .key;

          return SectionWithHabits(
            section: Section(
              id: entry.key,
              type: sectionType,
              orderIndex: sectionType.index,
            ),
            habits: entry.value
              ..sort((a, b) =>
                  a.habit.orderInSection.compareTo(b.habit.orderInSection)),
          );
        })
        .where((swh) => swh.habits.isNotEmpty)
        .toList();

    state = state.copyWith(sections: organizedSections);
  }

  @override
  void dispose() {
    _habitsSubscription.close();
    super.dispose();
  }
}
