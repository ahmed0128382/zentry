import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/habits/application/states/sections_with_habits_state.dart';
import 'package:zentry/src/features/habits/domain/entities/section_with_habits.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/section_widget.dart';

/// Sections + Habits List as Widget
class SectionsListWidget extends StatelessWidget {
  final SectionsWithHabitsState state;
  final DateTime selectedDate;
  final WidgetRef ref;

  const SectionsListWidget({
    super.key,
    required this.state,
    required this.selectedDate,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(
        child: Text(state.error!, style: const TextStyle(color: Colors.red)),
      );
    }

    if (state.sections.isEmpty) {
      return const Center(child: Text('No habits yet — add one!'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.sections.length,
      itemBuilder: (_, idx) {
        final SectionWithHabits sectionWithHabits = state.sections[idx];
        return SectionWidget(
          sectionWithHabits: sectionWithHabits,
          selectedDate: selectedDate,
          ref: ref,
        );
      },
    );
  }
}
