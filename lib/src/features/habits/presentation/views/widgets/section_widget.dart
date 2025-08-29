import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/habits/domain/entities/section_with_habits.dart';
import 'package:zentry/src/features/habits/domain/enums/section_type.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/habit_item_widget.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/section_header_widget.dart';

/// Single Section as Widget
class SectionWidget extends StatelessWidget {
  final SectionWithHabits sectionWithHabits;
  final DateTime selectedDate;
  final WidgetRef ref;

  const SectionWidget({
    super.key,
    required this.sectionWithHabits,
    required this.selectedDate,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final SectionType sectionType = sectionWithHabits.section.type;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeaderWidget(sectionType: sectionType),
        ...sectionWithHabits.habits.map(
          (hd) => HabitItemWidget(hd: hd, ref: ref, selectedDate: selectedDate),
        ),
        const Divider(),
      ],
    );
  }
}
