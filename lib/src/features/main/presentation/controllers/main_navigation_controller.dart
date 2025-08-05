import 'package:flutter_riverpod/flutter_riverpod.dart';

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
