import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:zentry/src/features/main/presentation/controllers/main_navigation_controller.dart';
import 'package:zentry/src/features/main/presentation/views/widgets/bottom_bar_item.dart';
import 'package:zentry/src/features/main/presentation/views/widgets/custom_navigation_bottom_bar.dart';
import 'package:zentry/src/shared/enums/menu_types.dart';

/// Provider to hold the selected [MoreMenuType]
final moreMenuTypeProvider = StateProvider<MoreMenuType>((ref) {
  return MoreMenuType.quarterCircleFab;
});

class MainViewBody extends ConsumerWidget {
  const MainViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(mainNavProvider);
    final controller = ref.read(mainNavProvider.notifier);
    final moreMenuType = ref.watch(moreMenuTypeProvider);

    final views = [
      const Center(child: Text('Tasks')), // 0
      const Center(child: Text('Calendar')), // 1
      const Center(child: Text('Matrix')), // 2
      const Center(child: Text('Pomodoro')), // 3
      const Center(child: Text('Countdown')), // 4
      const Center(child: Text('Habits')), // 5
      _buildSettingsView(ref), // 6
      const Center(child: Text('Profile')), // 7
    ];

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: views.length > currentIndex
            ? views
            : List.generate(currentIndex + 1, (i) => const SizedBox()),
      ),
      bottomNavigationBar: CustomNavigationBottomBar(
        moreMenuType: moreMenuType,
        currentIndex: currentIndex,
        onTap: controller.updateIndex,
        allItems: const [
          BottomBarItem(icon: Icons.check_circle, label: 'Today'),
          BottomBarItem(icon: Icons.calendar_today, label: 'Calendar'),
          BottomBarItem(icon: Icons.view_quilt, label: 'Matrix'),
          BottomBarItem(icon: Icons.timer, label: 'Pomodoro'),
          BottomBarItem(icon: Icons.hourglass_bottom, label: 'Countdown'),
          BottomBarItem(icon: Icons.track_changes, label: 'Habits'),
          BottomBarItem(icon: Icons.settings, label: 'Settings'),
          BottomBarItem(icon: Icons.person, label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildSettingsView(WidgetRef ref) {
    final selectedType = ref.watch(moreMenuTypeProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose Menu Type:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            DropdownButton<MoreMenuType>(
              value: selectedType,
              items: MoreMenuType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.toString().split('.').last),
                );
              }).toList(),
              onChanged: (newType) {
                if (newType != null) {
                  ref.read(moreMenuTypeProvider.notifier).state = newType;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
