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

// File: src/features/habits/application/controllers/sections_with_habits_controller.dart

import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  StreamSubscription<Result<List<SectionWithHabits>>>? _subscription;
  DateTime currentDay = DateTime.now();

  SectionsWithHabitsController({
    required this.getSectionsWithHabitsForDay,
  }) : super(SectionsWithHabitsState(sections: []));

  void watchSections(DateTime day) {
    currentDay = day;
    log('[SectionsWithHabitsController] Watching sections for day: $day');
    state = state.copyWith(isLoading: true, error: null);

    _subscription?.cancel();

    _subscription = getSectionsWithHabitsForDay(day).listen((result) {
      result.fold(
        (failure) {
          log('[SectionsWithHabitsController] Failed to load sections: $failure');
          state = state.copyWith(error: failure.toString(), isLoading: false);
        },
        (sectionsWithHabits) {
          log('[SectionsWithHabitsController] Retrieved ${sectionsWithHabits.length} sections from usecase');

          // Map to group habits by sectionId
          final Map<String, List<HabitDetails>> sectionsMap = {};

          for (final sectionWithHabits in sectionsWithHabits) {
            for (final habitDetail in sectionWithHabits.habits) {
              final key = habitDetail.habit.sectionId;
              if (key == null) {
                log('[SectionsWithHabitsController] Habit ${habitDetail.habit.title} has no sectionId, skipping');
                continue;
              }
              sectionsMap.putIfAbsent(key, () => []).add(habitDetail);
            }
          }

          log('[SectionsWithHabitsController] Grouped habits into ${sectionsMap.length} section keys');

          // Convert map to SectionWithHabits objects
          final List<SectionWithHabits> organizedSections =
              sectionsMap.entries.map((entry) {
            // find original section or create one with proper SectionType
            final originalSection =
                sectionsWithHabits.map((s) => s.section).firstWhere(
              (s) => s.id == entry.key,
              orElse: () {
                // try to find SectionType from the key
                SectionType type = sectionIds.entries
                    .firstWhere((e) => e.value == entry.key,
                        orElse: () => MapEntry(SectionType.anytime, 'anytime'))
                    .key;

                return Section(
                  id: entry.key,
                  type: type,
                  orderIndex: type.index,
                );
              },
            );

            // sort habits inside section
            entry.value.sort((a, b) =>
                a.habit.orderInSection.compareTo(b.habit.orderInSection));

            log('[SectionsWithHabitsController] Section "${originalSection.type.name}" has ${entry.value.length} habits');

            return SectionWithHabits(
              section: originalSection,
              habits: entry.value,
            );
          }).toList();

          log('[SectionsWithHabitsController] Loaded ${organizedSections.length} organized sections for $day');
          state = state.copyWith(sections: organizedSections, isLoading: false);
        },
      );
    });
  }

  @override
  void dispose() {
    log('[SectionsWithHabitsController] Disposing controller and cancelling subscription');
    _subscription?.cancel();
    super.dispose();
  }
}
