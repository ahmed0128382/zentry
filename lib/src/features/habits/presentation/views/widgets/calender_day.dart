import 'package:flutter/material.dart';

class CalendarDay extends StatelessWidget {
  final String day;
  final int date;
  final bool isToday; // kept for future use if you want a subtle marker
  final bool isSelected;
  final VoidCallback onTap;

  const CalendarDay({
    super.key,
    required this.day,
    required this.date,
    required this.isToday,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Highlight ONLY when selected
    final bool highlight = isSelected;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: 40,
        child: Column(
          children: [
            Text(
              day,
              style: TextStyle(
                color: highlight ? Colors.blue : Colors.grey,
                fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: highlight ? Colors.blue : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                date.toString(),
                style: TextStyle(
                  color: highlight ? Colors.white : Colors.black,
                  fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
