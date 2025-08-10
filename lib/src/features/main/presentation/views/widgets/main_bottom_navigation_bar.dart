import 'package:flutter/material.dart';
import 'package:zentry/src/features/main/presentation/views/widgets/bottom_bar_item.dart';
import 'package:zentry/src/features/main/presentation/views/widgets/custom_navigation_bottom_bar.dart';
import 'package:zentry/src/shared/enums/menu_types.dart';

class MainBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final MoreMenuType moreMenuType;

  const MainBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.moreMenuType,
  });

  static const List<BottomBarItem> items = [
    BottomBarItem(icon: Icons.check_circle, label: 'Today'),
    BottomBarItem(icon: Icons.calendar_today, label: 'Calendar'),
    BottomBarItem(icon: Icons.view_quilt, label: 'Matrix'),
    BottomBarItem(icon: Icons.timer, label: 'Pomodoro'),
    BottomBarItem(icon: Icons.manage_search_rounded, label: 'Search'),
    BottomBarItem(icon: Icons.track_changes, label: 'Habits'),
    BottomBarItem(icon: Icons.hourglass_bottom, label: 'Countdown'),
    BottomBarItem(icon: Icons.settings, label: 'Settings'),
    BottomBarItem(icon: Icons.person, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomNavigationBottomBar(
      moreMenuType: moreMenuType,
      currentIndex: currentIndex,
      onTap: onTap,
      allItems: items,
    );
  }
}
