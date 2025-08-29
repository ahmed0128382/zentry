// // File: src/features/habits/application/controllers/sections_with_habits_controller.dart
// import 'dart:async';
// import 'dart:developer';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:zentry/src/features/habits/application/states/sections_with_habits_state.dart';
// import 'package:zentry/src/features/habits/domain/entities/section.dart';
// import 'package:zentry/src/features/habits/domain/entities/section_with_habits.dart';
// import 'package:zentry/src/features/habits/domain/enums/section_type.dart';
// import 'package:zentry/src/features/habits/domain/usecases/get_sections_with_habits_for_day.dart';
// import 'package:zentry/src/shared/domain/errors/result.dart';

// class SectionsWithHabitsController
//     extends StateNotifier<SectionsWithHabitsState> {
//   final GetSectionsWithHabitsForDay getSectionsWithHabitsForDay;

//   StreamSubscription<Result<List<SectionWithHabits>>>? _subscription;
//   DateTime currentDay = DateTime.now();

//   SectionsWithHabitsController({
//     required this.getSectionsWithHabitsForDay,
//   }) : super(SectionsWithHabitsState(sections: []));

//   // void watchSections(DateTime day) {
//   //   currentDay = day;
//   //   state = state.copyWith(isLoading: true, error: null);

//   //   _subscription?.cancel(); // ✅ avoid multiple listeners

//   //   _subscription = getSectionsWithHabitsForDay(day).listen((result) {
//   //     result.fold(
//   //       (failure) {
//   //         log('[SectionsWithHabitsController] Failed to load sections: $failure');
//   //         state = state.copyWith(error: failure.toString(), isLoading: false);
//   //       },
//   //       (sections) {
//   //         log('[SectionsWithHabitsController] Loaded ${sections.length} sections for $day');
//   //         state = state.copyWith(sections: sections, isLoading: false);
//   //       },
//   //     );
//   //   });
//   // }
//   void watchSections(DateTime day) {
//     currentDay = day;
//     state = state.copyWith(isLoading: true, error: null);

//     _subscription?.cancel(); // تجنب الاستماع المزدوج

//     _subscription = getSectionsWithHabitsForDay(day).listen((result) {
//       result.fold(
//         (failure) {
//           log('[SectionsWithHabitsController] Failed to load sections: $failure');
//           state = state.copyWith(error: failure.toString(), isLoading: false);
//         },
//         (sections) {
//           // خريطة تحدد id ثابت لكل SectionType
//           const sectionIds = {
//             SectionType.morning: 'morning',
//             SectionType.afternoon: 'afternoon',
//             SectionType.evening: 'evening',
//             SectionType.anytime: 'anytime',
//           };

//           // ضمان وجود جميع الأقسام حتى لو كانت فارغة
//           final allSections = SectionType.values.map((type) {
//             final found = sections.firstWhere(
//               (s) => s.section.type == type,
//               orElse: () => SectionWithHabits(
//                 section: Section(
//                   id: sectionIds[type]!, // id ثابت لكل SectionType
//                   type: type,
//                   orderIndex: type.index,
//                 ),
//                 habits: [],
//               ),
//             );
//             return found;
//           }).toList();

//           log('[SectionsWithHabitsController] Loaded ${allSections.length} sections for $day');
//           state = state.copyWith(sections: allSections, isLoading: false);
//         },
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _subscription?.cancel();
//     super.dispose();
//   }
// }
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/habits/application/controllers/habits_controller.dart';
import 'package:zentry/src/features/habits/application/providers/habits_controller_provider.dart';
import 'package:zentry/src/features/habits/application/states/sections_with_habits_state.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_details.dart';
import 'package:zentry/src/features/habits/domain/entities/section.dart';
import 'package:zentry/src/features/habits/domain/entities/section_with_habits.dart';
import 'package:zentry/src/features/habits/domain/enums/section_type.dart';
import 'package:zentry/src/features/habits/domain/usecases/get_sections_with_habits_for_day.dart';
import 'package:zentry/src/shared/domain/errors/result.dart';

class SectionsWithHabitsController
    extends StateNotifier<SectionsWithHabitsState> {
  final GetSectionsWithHabitsForDay getSectionsWithHabitsForDay;
  final Ref ref; // we need this to listen to habits state

  StreamSubscription<Result<List<SectionWithHabits>>>? _subscription;
  late final ProviderSubscription _habitsSubscription;

  DateTime currentDay = DateTime.now();

  SectionsWithHabitsController({
    required this.getSectionsWithHabitsForDay,
    required this.ref,
  }) : super(SectionsWithHabitsState(sections: [])) {
    // Listen to habits changes
    _habitsSubscription = ref.listen<HabitsState>(
      habitsControllerProvider,
      (previous, next) {
        // Rebuild sections whenever habits change
        watchSections(currentDay);
      },
      fireImmediately: true,
    );
  }

  void watchSections(DateTime day) {
    currentDay = day;
    final habitsState = ref.read(habitsControllerProvider);
    final habits = habitsState.habits;

    // Group habits by section
    final Map<String, List<HabitDetails>> sectionsMap = {};
    for (final hd in habits) {
      final key = hd.habit.sectionId ?? 'anytime';
      sectionsMap.putIfAbsent(key, () => []).add(hd);
    }

    // Build SectionWithHabits
    final List<SectionWithHabits> organizedSections = sectionsMap.entries
        .map((entry) {
          final sectionType = sectionIds.entries
              .firstWhere((e) => e.value == entry.key,
                  orElse: () => MapEntry(SectionType.anytime, 'anytime'))
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
    _subscription?.cancel();
    _habitsSubscription.close();
    super.dispose();
  }
}
