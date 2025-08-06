import 'package:flutter/material.dart';
import 'package:zentry/src/features/main/presentation/views/widgets/settings_menu_type_dropdown.dart';

final List<Widget> mainViewPages = [
  const Center(child: Text('Tasks')), // 0
  const Center(child: Text('Calendar')), // 1
  const Center(child: Text('Matrix')), // 2
  const Center(child: Text('Pomodoro')), // 3
  const Center(child: Text('Countdown')), // 4
  const Center(child: Text('Habits')), // 5
  const SettingsMenuTypeDropdown(), // 6
  const Center(child: Text('Profile')), // 7
];
