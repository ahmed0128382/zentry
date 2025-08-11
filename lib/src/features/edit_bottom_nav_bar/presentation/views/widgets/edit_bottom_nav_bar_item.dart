import 'package:flutter/material.dart';
import 'package:zentry/src/features/edit_bottom_nav_bar/presentation/views/widgets/edit_nav_bar_tab_item.dart';
import 'package:zentry/src/features/edit_bottom_nav_bar/presentation/views/widgets/max_tab_section.dart';

class EditBottomNavBarViewBody extends StatelessWidget {
  const EditBottomNavBarViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: const [
              EditNavBarTabItem(
                icon: Icons.check_circle_outline,
                title: 'Task',
                subtitle: 'Manage your task with lists and filters.',
                isActive: true,
              ),
              EditNavBarTabItem(
                icon: Icons.calendar_today,
                title: 'Calendar',
                subtitle: 'Manage your task with five calendar views.',
                isActive: false,
              ),
              EditNavBarTabItem(
                icon: Icons.timer,
                title: 'Pomodoro',
                subtitle: 'Use the Pomo timer or stopwatch to keep focus.',
                isActive: false,
              ),
              EditNavBarTabItem(
                icon: Icons.favorite_border,
                title: 'Habit Tracker',
                subtitle: 'Develop a habit and keep track of it.',
                isActive: false,
              ),
              EditNavBarTabItem(
                icon: Icons.star_border,
                title: 'Countdown',
                subtitle: 'Remember every special day.',
                isActive: false,
              ),
              EditNavBarTabItem(
                icon: Icons.search,
                title: 'Search',
                subtitle: 'Do a quick search easily.',
                isActive: false,
              ),
              EditNavBarTabItem(
                icon: Icons.apps,
                title: 'Eisenhower Matrix',
                subtitle: 'Focus on what\'s important and urgent.',
                isActive: false,
              ),
              EditNavBarTabItem(
                icon: Icons.settings,
                title: 'Settings',
                subtitle: 'Make changes to the current settings.',
                isActive: false,
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        const MaxTabsSection(),
      ],
    );
  }
}
