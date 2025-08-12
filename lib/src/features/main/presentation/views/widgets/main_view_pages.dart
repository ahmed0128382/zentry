import 'package:flutter/material.dart';
import 'package:zentry/src/features/Focus/presentation/views/focus_view.dart';
import 'package:zentry/src/features/calender/presentation/views/calender_view.dart';
import 'package:zentry/src/features/countdown/presentation/views/countdown_view.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/presentation/views/eisen_hower_matrix_view.dart';
import 'package:zentry/src/features/habits/presentation/views/habits_view.dart';

import 'package:zentry/src/features/search/presentation/views/search_view.dart';
import 'package:zentry/src/features/settings/presentation/views/settings_view.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/to_do_today_view.dart';
import 'package:zentry/src/shared/enums/main_view_pages_index.dart';

/// Map linking MainViewPageIndex enum values to their corresponding pages (widgets).
/// Helps in easily retrieving the correct view for a given page index.
final Map<MainViewPageIndex, Widget> mainViewPagesMap = {
  MainViewPageIndex.toDoToday: const ToDoTodayView(),
  MainViewPageIndex.calendar: const CalenderView(),
  MainViewPageIndex.eisenhowerMatrix: const EisenHowerMatrixView(),
  MainViewPageIndex.focus: const FocusView(),
  MainViewPageIndex.search: const SearchView(),
  MainViewPageIndex.habits: const HabitsView(),
  MainViewPageIndex.countdown: const CountdownView(),
  MainViewPageIndex.settings: const SettingsView(),
  //MainViewPageIndex.profile: const ProfileView(),
};
