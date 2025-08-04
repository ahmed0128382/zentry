import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/main/presentation/controllers/main_navigation_controller.dart';

class MainViewBody extends ConsumerWidget {
  const MainViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(mainNavProvider);
    final controller = ref.read(mainNavProvider.notifier);

    final views = [
      const Center(child: Text('Tasks')),
      const Center(child: Text('Calendar')),
      const Center(child: Text('Progress')),
      const Center(child: Text('Profile')),
    ];

    return Scaffold(
      body: views[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: controller.setIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle), label: 'Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.timeline), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
