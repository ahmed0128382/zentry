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
import 'package:zentry/src/shared/enums/main_view_pages_Indexes.dart';

// final List<Widget> mainViewPages = [
//   const ToDoTodayView(), // 0
//   const CalenderView(), // 1
//   const EisenHowerMatrixView(), // 2
//   const PomodoroView(), // 3
//   const SearchView(), // 4
//   const HabitsView(), // 5
//   const CountdownView(), // 6
//   const SettingsView(), // 7
//   const ProfileView(), // 8
// ];
final Map<MainViewPageIndex, Widget> mainViewPagesMap = {
  MainViewPageIndex.toDoToday: const ToDoTodayView(),
  MainViewPageIndex.calendar: const CalenderView(),
  MainViewPageIndex.eisenhowerMatrix: const EisenHowerMatrixView(),
  MainViewPageIndex.pomodoro: const PomodoroView(),
  MainViewPageIndex.search: const SearchView(),
  MainViewPageIndex.habits: const HabitsView(),
  MainViewPageIndex.countdown: const CountdownView(),
  MainViewPageIndex.settings: const SettingsView(),
  MainViewPageIndex.profile: const ProfileView(),
};
