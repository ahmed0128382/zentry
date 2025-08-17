import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';
import 'package:zentry/src/core/utils/app_colors.dart';
import 'package:zentry/src/core/utils/app_decorations.dart';
import 'package:zentry/src/core/utils/palette.dart';
import 'package:zentry/src/features/appearance/application/providers/appearance_controller_provider.dart';
import 'package:zentry/src/features/main/presentation/views/widgets/bottom_bar_item.dart';
import 'package:zentry/src/features/main/presentation/views/widgets/quarter_circle_menu.dart';
import 'package:zentry/src/shared/enums/menu_types.dart';

class CustomNavigationBottomBar extends ConsumerWidget {
  final MoreMenuType moreMenuType;
  final int currentIndex;
  final List<BottomBarItem> allItems;
  final ValueChanged<int> onTap;

  static const int visibleCount = 4;

  const CustomNavigationBottomBar({
    super.key,
    required this.currentIndex,
    required this.allItems,
    required this.onTap,
    this.moreMenuType = MoreMenuType.expandableOverlay,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch appearance changes reactively
    //final appearance = ref.watch(appearanceControllerProvider);
    final palette = ref.watch(appPaletteProvider);

// Update AppColors dynamically
    //AppColors.updateFromAppearance(appearance);

    final visibleItems = allItems.take(visibleCount).toList();
    final hiddenItems = allItems.skip(visibleCount).toList();

    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth / (visibleCount + 1);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 70,
          decoration: AppDecorations.navBarFor(
            palette,
          ),
        ),

        // Glow Indicator
        if (currentIndex < visibleCount)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutQuint,
            left: currentIndex * itemWidth + itemWidth / 2 - 25,
            bottom: 10,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: palette.primary.withValues(alpha: 0.6),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),

        // Bottom Icons
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            children: [
              for (int i = 0; i < visibleItems.length; i++)
                _buildNavItem(context, visibleItems[i], i, itemWidth, palette),

              // More Icon
              GestureDetector(
                onTap: () {
                  switch (moreMenuType) {
                    case MoreMenuType.modalBottomSheet:
                      _showMoreItems(context, hiddenItems, palette);
                      break;
                    case MoreMenuType.expandableOverlay:
                      _showExpandableMenu(context, hiddenItems, palette);
                      break;
                    case MoreMenuType.quarterCircleFab:
                      _showQuarterCircleFab(context, hiddenItems, palette);
                      break;
                  }
                },
                child: SizedBox(
                  width: itemWidth,
                  height: 70,
                  child: const Icon(Icons.more_horiz,
                      color: Colors.grey, size: 28),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(BuildContext context, BottomBarItem item, int index,
      double width, Palette palette) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: SizedBox(
        width: width,
        height: 70,
        child: Icon(
          item.icon,
          color:
              isSelected ? palette.text : palette.icon.withValues(alpha: 0.3),
          size: 28,
        ),
      ),
    );
  }

  void _showMoreItems(
      BuildContext context, List<BottomBarItem> items, Palette palette) {
    showModalBottomSheet(
      context: context,
      backgroundColor: palette.primary.withValues(alpha: 0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          children: List.generate(items.length, (index) {
            final item = items[index];
            final overallIndex = index + visibleCount;
            return GestureDetector(
              onTap: () {
                Navigator.pop(context);
                onTap(overallIndex);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(item.icon, color: palette.text, size: 28),
                  const SizedBox(height: 4),
                  Text(item.label,
                      style: TextStyle(fontSize: 12, color: palette.text)),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  void _showExpandableMenu(
      BuildContext context, List<BottomBarItem> items, Palette palette) {
    final overlay = Overlay.of(context);

    late OverlayEntry overlayEntry; // <-- Declare before using

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Dismissible background
            GestureDetector(
              onTap: () => overlayEntry.remove(),
              child: Container(
                color: Colors.black.withValues(alpha: 0.4),
              ),
            ),
            // Expandable Menu
            Positioned(
              bottom: 80,
              right: 20,
              child: Material(
                color: palette.primary.withValues(alpha: 0.5),
                elevation: 8,
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(items.length, (index) {
                      final item = items[index];
                      final overallIndex =
                          index + CustomNavigationBottomBar.visibleCount;
                      return GestureDetector(
                        onTap: () {
                          overlayEntry.remove();
                          onTap(overallIndex);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(item.icon, color: palette.text, size: 24),
                              const SizedBox(width: 8),
                              Text(
                                item.label,
                                style: TextStyle(
                                    fontSize: 14, color: palette.text),
                                selectionColor: palette.text,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(overlayEntry);
  }

  void _showQuarterCircleFab(
      BuildContext context, List<BottomBarItem> items, Palette palette) {
    final overlay = Overlay.of(context, rootOverlay: true);
    if (overlay == null) return;

    late final OverlayEntry entry;
    late final AnimationController controller;

    controller = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 250),
    );

    entry = OverlayEntry(
      builder: (_) => QuarterCircleMenu(
        icons: items.map((item) => item.icon).toList(),
        animation: controller,
        onClose: () {
          if (entry.mounted) {
            controller.reverse().then((_) {
              entry.remove();
              controller.dispose();
            });
          }
        },
        // Pass correct global index
        onIconTap: (indexInHidden) {
          final globalIndex =
              CustomNavigationBottomBar.visibleCount + indexInHidden;
          onTap(globalIndex); // This updates your UI
        },
      ),
    );

    overlay.insert(entry);
    controller.forward();
  }
}
