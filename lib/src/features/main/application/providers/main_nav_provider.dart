import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/main/application/controllers/main_navigation_controller.dart';

/// Provider to hold the selected tab index if needed for other UI state
final mainNavProvider =
    StateNotifierProvider<MainNavigationController, int>((ref) {
  return MainNavigationController();
});
