// main_navigation_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/shared/enums/menu_types.dart';

/// Provider to hold the selected tab index if needed for other UI state
final mainNavProvider =
    StateNotifierProvider<MainNavigationController, int>((ref) {
  return MainNavigationController();
});

class MainNavigationController extends StateNotifier<int> {
  MainNavigationController() : super(0);

  void updateIndex(int index) {
    if (index != state) state = index;
  }
}

/// Provider to hold the selected [MoreMenuType]
final moreMenuTypeProvider = StateProvider<MoreMenuType>((ref) {
  return MoreMenuType.quarterCircleFab;
});
