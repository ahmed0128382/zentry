import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainNavigationController extends Notifier<int> {
  @override
  int build() => 0;

  void setIndex(int newIndex) => state = newIndex;
}

final mainNavProvider = NotifierProvider<MainNavigationController, int>(
    () => MainNavigationController());
