import 'package:flutter/material.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/calender_day.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> daysOfWeek = [
      'Fri',
      'Sat',
      'Sun',
      'Mon',
      'Tue',
      'Wed',
      'Thu'
    ];
    final List<int> dates = [1, 2, 3, 4, 5, 6, 7];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      color: Theme.of(context).cardColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(7, (index) {
          final bool isToday = dates[index] == 7; // Example: today is 7th
          return CalendarDay(
            day: daysOfWeek[index],
            date: dates[index],
            isToday: isToday,
          );
        }),
      ),
    );
  }
}
