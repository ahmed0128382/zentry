import 'package:flutter/material.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/calender_header.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/habit_item.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/habits_view_header.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/section_header.dart';

class HabitsView extends StatelessWidget {
  const HabitsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const HabitsViewHeader(),
          const CalendarHeader(),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SectionHeader(title: 'Others'),
                    HabitItem(
                      icon: Icons.brush,
                      iconColor: Colors.blue,
                      backgroundColor: Color(0x1A2196F3), // 10% opacity
                      title: 'Brush your teeth',
                      totalDays: 7,
                    ),
                    HabitItem(
                      icon: Icons.bedtime,
                      iconColor: Colors.deepPurple,
                      backgroundColor: Color(0x1A673AB7),
                      title: 'Early to bed',
                      totalDays: 7,
                    ),
                    HabitItem(
                      icon: Icons.directions_run,
                      iconColor: Colors.orange,
                      backgroundColor: Color(0x1AFF9800),
                      title: 'Any sport daily',
                      totalDays: 1,
                    ),
                    HabitItem(
                      icon: Icons.check,
                      iconColor: Colors.red,
                      backgroundColor: Color(0x1AF44336),
                      title: 'Check before bed that u a...',
                      progressText: '0/1 Count',
                      totalDays: 5,
                    ),
                    HabitItem(
                      icon: Icons.local_drink,
                      iconColor: Colors.teal,
                      backgroundColor: Color(0x1A009688),
                      title: 'Drink water',
                      progressText: '0/7 Cup',
                      totalDays: 6,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
