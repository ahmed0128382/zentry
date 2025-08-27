// File: src/features/habits/application/controllers/sections_with_habits_controller.dart
import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/habits/application/states/sections_with_habits_state.dart';
import 'package:zentry/src/features/habits/domain/entities/section_with_habits.dart';
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
    state = state.copyWith(isLoading: true, error: null);

    _subscription?.cancel(); // ✅ avoid multiple listeners

    _subscription = getSectionsWithHabitsForDay(day).listen((result) {
      result.fold(
        (failure) {
          log('[SectionsWithHabitsController] Failed to load sections: $failure');
          state = state.copyWith(error: failure.toString(), isLoading: false);
        },
        (sections) {
          log('[SectionsWithHabitsController] Loaded ${sections.length} sections for $day');
          state = state.copyWith(sections: sections, isLoading: false);
        },
      );
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
