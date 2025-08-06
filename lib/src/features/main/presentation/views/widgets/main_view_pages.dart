import 'package:flutter/material.dart';
import 'package:zentry/src/features/calender/presentation/views/calender_view.dart';
import 'package:zentry/src/features/countdown/presentation/views/countdown_view.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/presentation/views/eisen_hower_matrix_view.dart';
import 'package:zentry/src/features/habits/presentation/views/habits_view.dart';
import 'package:zentry/src/features/pomodoro/presentation/views/pomodoro_view.dart';
import 'package:zentry/src/features/profile/presentation/views/profile_view.dart';
import 'package:zentry/src/features/search/presentation/views/search_view.dart';
import 'package:zentry/src/features/settings/presentation/views/settings_view.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/to_do_today_view.dart';

final List<Widget> mainViewPages = [
  const ToDoTodayView(), // 0
  const CalenderView(), // 1
  const EisenHowerMatrixView(), // 2
  const PomodoroView(), // 3
  const SearchView(), // 4
  const HabitsView(), // 5
  const CountdownView(), // 6
  const SettingsView(), // 7
  const ProfileView(), // 8
];
