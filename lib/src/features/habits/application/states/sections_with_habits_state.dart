// File: src/features/habits/application/states/sections_with_habits_state.dart
import 'package:zentry/src/features/habits/domain/entities/section_with_habits.dart';

class SectionsWithHabitsState {
  final List<SectionWithHabits> sections;
  final bool isLoading;
  final String? error;

  SectionsWithHabitsState({
    required this.sections,
    this.isLoading = false,
    this.error,
  });

  // Add this named constructor
  factory SectionsWithHabitsState.initial() {
    return SectionsWithHabitsState(sections: [], isLoading: false, error: null);
  }

  SectionsWithHabitsState copyWith({
    List<SectionWithHabits>? sections,
    bool? isLoading,
    String? error,
  }) {
    return SectionsWithHabitsState(
      sections: sections ?? this.sections,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
