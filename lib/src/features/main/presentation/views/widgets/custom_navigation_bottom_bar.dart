import 'package:flutter/material.dart';
import 'package:zentry/src/core/utils/app_colors.dart';
import 'package:zentry/src/core/utils/app_decorations.dart';
import 'package:zentry/src/features/main/presentation/views/widgets/bottom_bar_item.dart';

// class CustomNavigationBottomBar extends StatefulWidget {
//   final int currentIndex;
//   final List<IconData> icons;
//   final ValueChanged<int> onTap;

//   const CustomNavigationBottomBar({
//     super.key,
//     required this.currentIndex,
//     required this.icons,
//     required this.onTap,
//   });

//   @override
//   State<CustomNavigationBottomBar> createState() =>
//       _CustomNavigationBottomBarState();
// }

// class _CustomNavigationBottomBarState extends State<CustomNavigationBottomBar> {
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final itemWidth = screenWidth / widget.icons.length;

//     return Stack(
//       alignment: Alignment.bottomCenter,
//       children: [
//         Container(
//           height: 70,
//           decoration: AppDecorations.navBarBox,
//         ),

//         // Animated Glow Indicator
//         AnimatedPositioned(
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOutQuint,
//           left: widget.currentIndex * itemWidth + itemWidth / 2 - 25,
//           bottom: 10,
//           child: Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: AppColors.primary.withValues(alpha: 0.6),
//                   blurRadius: 20,
//                   spreadRadius: 2,
//                 ),
//               ],
//             ),
//           ),
//         ),

//         // Icons Row
//         Positioned(
//           bottom: 0,
//           left: 0,
//           right: 0,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: List.generate(
//               widget.icons.length,
//               (index) => GestureDetector(
//                 onTap: () => widget.onTap(index),
//                 child: SizedBox(
//                   width: itemWidth,
//                   height: 70,
//                   child: Icon(
//                     widget.icons[index],
//                     color: index == widget.currentIndex
//                         ? Colors.white
//                         : Colors.grey,
//                     size: 28,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class CustomNavigationBottomBar extends StatelessWidget {
  final int currentIndex;
  final List<BottomBarItem> allItems;
  final ValueChanged<int> onTap;

  static const int visibleCount = 4;

  const CustomNavigationBottomBar({
    super.key,
    required this.currentIndex,
    required this.allItems,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final visibleItems = allItems.take(visibleCount).toList();
    final hiddenItems = allItems.skip(visibleCount).toList();

    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth / (visibleCount + 1);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 70,
          decoration: AppDecorations.navBarBox,
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
                    color: AppColors.primary.withOpacity(0.6),
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
                _buildNavItem(context, visibleItems[i], i, itemWidth),

              // More Icon
              GestureDetector(
                onTap: () => _showMoreItems(context, hiddenItems),
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

  Widget _buildNavItem(
      BuildContext context, BottomBarItem item, int index, double width) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: SizedBox(
        width: width,
        height: 70,
        child: Icon(
          item.icon,
          color: isSelected ? Colors.white : Colors.grey,
          size: 28,
        ),
      ),
    );
  }

  void _showMoreItems(BuildContext context, List<BottomBarItem> items) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
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
                  Icon(item.icon, color: Colors.grey, size: 28),
                  const SizedBox(height: 4),
                  Text(item.label, style: const TextStyle(fontSize: 12)),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
