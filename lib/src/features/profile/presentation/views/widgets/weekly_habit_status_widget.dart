import 'package:flutter/material.dart';
import 'package:zentry/src/features/profile/presentation/views/widgets/habit_day.dart';

class WeeklyHabitStatusWidget extends StatelessWidget {
  const WeeklyHabitStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('13',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Text('Weekly Check-ins', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            HabitDay(day: 'Mon', progress: 1.0, color: Colors.blue),
            HabitDay(day: 'Tue', progress: 0.8, color: Colors.blue),
            HabitDay(day: 'Wed', progress: 0.6, color: Colors.blue),
            HabitDay(day: 'Thu', progress: 0.0, color: Colors.grey),
            HabitDay(day: 'Fri', progress: 0.0, color: Colors.grey),
            HabitDay(day: 'Sat', progress: 0.0, color: Colors.grey),
            HabitDay(day: 'Sun', progress: 0.0, color: Colors.grey),
          ],
        ),
      ],
    );
  }
}
