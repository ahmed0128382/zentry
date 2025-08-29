import 'package:flutter/material.dart';
import 'package:zentry/src/features/habits/domain/enums/weekday.dart';

class WeekdaySelector extends StatelessWidget {
  final Set<Weekday> selectedDays;
  const WeekdaySelector({super.key, required this.selectedDays});
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
            if (val) {
              selectedDays.add(day);
            } else {
              selectedDays.remove(day);
            }
          },
        );
      }).toList(),
    );
  }
}
