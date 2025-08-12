import 'package:flutter/material.dart';
import 'package:zentry/src/features/profile/presentation/views/widgets/achievement_score_widget.dart';
import 'package:zentry/src/features/profile/presentation/views/widgets/badge_widget.dart';
import 'package:zentry/src/features/profile/presentation/views/widgets/focus_statistics.dart';
import 'package:zentry/src/features/profile/presentation/views/widgets/profile_section.dart';
import 'package:zentry/src/features/profile/presentation/views/widgets/profile_view_header.dart';
import 'package:zentry/src/features/profile/presentation/views/widgets/task_statistics_widget.dart';
import 'package:zentry/src/features/profile/presentation/views/widgets/weekly_habit_status_widget.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: const [
              ProfileHeader(),
              SizedBox(height: 16),
              ProfileSection(
                title: 'My Badges',
                showArrow: true,
                content: BadgesWidget(),
              ),
              SizedBox(height: 16),
              ProfileSection(
                title: 'My Achievement Score',
                showArrow: true,
                content: AchievementScoreWidget(),
              ),
              SizedBox(height: 16),
              ProfileSection(
                title: 'Task Statistics',
                showArrow: true,
                content: TaskStatisticsWidget(),
              ),
              SizedBox(height: 16),
              ProfileSection(
                title: 'Focus Statistics',
                showArrow: true,
                content: FocusStatisticsWidget(),
              ),
              SizedBox(height: 16),
              ProfileSection(
                title: 'Weekly Habit Status',
                content: WeeklyHabitStatusWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
