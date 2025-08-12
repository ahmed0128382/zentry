// main_navigation_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainNavigationController extends StateNotifier<int> {
  MainNavigationController() : super(0);

  void updateIndex(int index) {
    if (index != state) state = index;
  }
}
