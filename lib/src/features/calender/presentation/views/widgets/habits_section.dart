// Habits section listing habits
import 'package:flutter/material.dart';
import 'package:zentry/src/features/calender/presentation/views/widgets/habit_item.dart';

class HabitsSection extends StatelessWidget {
  const HabitsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HABIT',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          HabitItem(
            title: 'Brush your teeth',
            icon: Icons.spa,
            time: 'Today',
          ),
          HabitItem(
            title: 'Early to bed',
            icon: Icons.bedtime,
            time: 'Today',
          ),
          HabitItem(
            title: 'Any sport daily',
            icon: Icons.directions_run,
            time: 'Today',
          ),
          HabitItem(
            title: 'Check before bed that u are fine',
            icon: Icons.sentiment_satisfied_alt,
            time: 'Today',
          ),
        ],
      ),
    );
  }
}
