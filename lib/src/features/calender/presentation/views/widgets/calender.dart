// Calendar widget showing week days and days of month
import 'package:flutter/material.dart';
import 'package:zentry/src/features/calender/presentation/views/widgets/day_cell.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final firstDayOfWeek = DateTime(now.year, now.month, 1).weekday;

    final List<String> weekDays = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun'
    ];
    final List<Widget> dayWidgets = [];

    // Add empty cells before 1st day of month
    for (int i = 1; i < firstDayOfWeek; i++) {
      dayWidgets.add(const SizedBox());
    }

    // Add days of the month
    for (int i = 1; i <= daysInMonth; i++) {
      final isToday = i == now.day;
      dayWidgets.add(DayCell(day: i, isToday: isToday));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: weekDays
                .map((day) => Text(
                      day,
                      style: const TextStyle(color: Colors.grey),
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 7,
            children: dayWidgets,
          ),
        ],
      ),
    );
  }
}
