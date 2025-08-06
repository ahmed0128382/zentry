import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:zentry/src/features/main/presentation/controllers/main_navigation_controller.dart';
import 'package:zentry/src/features/main/presentation/views/widgets/bottom_bar_item.dart';
import 'package:zentry/src/features/main/presentation/views/widgets/custom_navigation_bottom_bar.dart';
import 'package:zentry/src/features/main/presentation/views/widgets/main_view_pages.dart';

class MainViewBody extends ConsumerWidget {
  const MainViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(mainNavProvider);
    final controller = ref.read(mainNavProvider.notifier);
    final moreMenuType = ref.watch(moreMenuTypeProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: mainViewPages.length > currentIndex
            ? mainViewPages
            : List.generate(currentIndex + 1, (i) => const SizedBox()),
      ),
      bottomNavigationBar: CustomNavigationBottomBar(
        moreMenuType: moreMenuType,
        currentIndex: currentIndex,
        onTap: controller.updateIndex,
        allItems: const [
          BottomBarItem(icon: Icons.check_circle, label: 'Today'), //0
          BottomBarItem(icon: Icons.calendar_today, label: 'Calendar'), //1
          BottomBarItem(icon: Icons.view_quilt, label: 'Matrix'), //2
          BottomBarItem(icon: Icons.timer, label: 'Pomodoro'), //3
          BottomBarItem(icon: Icons.manage_search_rounded, label: 'Search'), //4
          BottomBarItem(icon: Icons.track_changes, label: 'Habits'), //5
          BottomBarItem(icon: Icons.hourglass_bottom, label: 'Countdown'), //6
          BottomBarItem(icon: Icons.settings, label: 'Settings'), //7
          BottomBarItem(icon: Icons.person, label: 'Profile'), //8
        ],
      ),
    );
  }
}
