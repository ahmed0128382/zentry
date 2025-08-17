// Single day cell widget in calendar
import 'package:flutter/material.dart';
import 'package:zentry/src/core/utils/app_colors.dart';

class DayCell extends StatelessWidget {
  final int day;
  final bool isToday;

  const DayCell({required this.day, required this.isToday, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color:
            isToday ? AppColors.peacefulSeaBlue.withValues(alpha: 0.8) : null,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$day',
              style: TextStyle(
                color: isToday ? Colors.white : Colors.black,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (!isToday)
              Container(
                margin: const EdgeInsets.only(top: 2),
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
