import 'package:flutter/material.dart';

class HabitDay extends StatelessWidget {
  final String day;
  final double progress;
  final Color color;

  const HabitDay({
    super.key,
    required this.day,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 4,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            backgroundColor: Colors.grey.shade200,
          ),
        ),
        const SizedBox(height: 8),
        Text(day),
      ],
    );
  }
}
