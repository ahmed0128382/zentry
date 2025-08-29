import 'package:flutter/material.dart';
import 'package:zentry/src/features/habits/domain/enums/weekday.dart';

class WeekdaySelector extends StatelessWidget {
  final Set<Weekday> selectedDays;
  final Function(Set<Weekday>)? onChanged;

  const WeekdaySelector({
    super.key,
    required this.selectedDays,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: Weekday.values.map((day) {
        final selected = selectedDays.contains(day);
        return ChoiceChip(
          label: Text(day.toString().split('.').last.substring(0, 3)),
          selected: selected,
          onSelected: (val) {
            final newSet = Set<Weekday>.from(selectedDays);
            if (val) {
              newSet.add(day);
            } else {
              newSet.remove(day);
            }

            onChanged?.call(newSet);
          },
        );
      }).toList(),
    );
  }
}
