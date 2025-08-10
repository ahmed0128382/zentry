import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:zentry/src/features/main/domain/entities/main_view_page_index.dart';
import 'package:zentry/src/features/main/presentation/controllers/current_tab_index_provider.dart';
import 'package:zentry/src/features/main/presentation/controllers/main_navigation_controller.dart';
import 'package:zentry/src/features/main/presentation/views/widgets/main_bottom_navigation_bar.dart';
import 'package:zentry/src/features/main/presentation/views/widgets/main_view_pages.dart';
import 'package:zentry/src/shared/enums/main_view_pages_index.dart';

class MainViewBody extends ConsumerWidget {
  final Widget child;
  final String location;

  const MainViewBody({
    super.key,
    required this.child,
    required this.location,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Current index derived solely from location string
    final currentIndex = ref.watch(currentTabIndexProvider(location));
    // You can remove the controller reference as it's no longer needed for manual update
    final moreMenuType = ref.watch(moreMenuTypeProvider);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop && currentIndex > 0) {
          // Navigate back to default tab route when pressing back button and not on first tab
          context.go(MainViewPageIndex.toDoToday.route);
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: mainViewPagesMap.values.toList(),
        ),
        bottomNavigationBar: MainBottomNavigationBar(
          currentIndex: currentIndex,
          moreMenuType: moreMenuType,
          onTap: (index) {
            // Navigate by route only; no manual state update needed
            context.go(MainViewPageIndex.values[index].route);
          },
        ),
      ),
    );
  }
}
