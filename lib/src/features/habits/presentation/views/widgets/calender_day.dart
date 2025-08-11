import 'package:flutter/material.dart';

class CalendarDay extends StatelessWidget {
  final String day;
  final int date;
  final bool isToday;

  const CalendarDay({
    super.key,
    required this.day,
    required this.date,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: Column(
        children: [
          Text(
            day,
            style: TextStyle(
              color: isToday ? Colors.blue : Colors.grey,
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isToday ? Colors.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              date.toString(),
              style: TextStyle(
                color: isToday ? Colors.white : Colors.black,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
