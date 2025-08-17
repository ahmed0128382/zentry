// import 'dart:math';
// import 'package:flutter/material.dart';

// class QuarterCircleMenu extends StatefulWidget {
//   final List<IconData> icons;
//   final void Function(int index) onIconTap;
//   final VoidCallback onClose;

//   const QuarterCircleMenu({
//     super.key,
//     required this.icons,
//     required this.onIconTap,
//     required this.onClose,
//   });

//   @override
//   State<QuarterCircleMenu> createState() => _QuarterCircleMenuState();
// }

// class _QuarterCircleMenuState extends State<QuarterCircleMenu>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 400),
//     )..forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final int count = widget.icons.length;

//     // Adjust radius based on number of icons
//     final double radius = 100 + (count > 3 ? (count - 3) * 45 : 0);

//     // Adjust padding angle so the total angle doesn’t shrink too much
//     final double paddingAngle = (count >= 4) ? 5 * (pi / 180) : 10 * (pi / 180);
//     final double totalAngle = pi / 2; // 90 degrees
//     final double step =
//         count == 1 ? 0 : (totalAngle - 2 * paddingAngle) / (count - 1);

//     return Stack(
//       children: [
//         // Tap outside to close
//         GestureDetector(
//           onTap: widget.onClose,
//           child: Container(color: Colors.black.withOpacity(0.3)),
//         ),

//         // FAB icons
//         Positioned(
//           bottom: 24,
//           right: 24,
//           child: SizedBox(
//             width: radius + 80,
//             height: radius + 80,
//             child: Stack(
//               alignment: Alignment.bottomRight,
//               children: List.generate(count, (index) {
//                 final double angle = paddingAngle + step * index;
//                 final double targetDx = radius * cos(angle);
//                 final double targetDy = radius * sin(angle);

//                 return AnimatedBuilder(
//                   animation: _controller,
//                   builder: (_, child) {
//                     final progress =
//                         Curves.easeOutBack.transform(_controller.value);
//                     final dx = targetDx * progress;
//                     final dy = targetDy * progress;

//                     return Positioned(
//                       right: dx,
//                       bottom: dy,
//                       child: child!,
//                     );
//                   },
//                   child: GestureDetector(
//                     onTap: () => widget.onIconTap(index),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             blurRadius: 10,
//                             offset: const Offset(2, 3),
//                           )
//                         ],
//                       ),
//                       padding: const EdgeInsets.all(12),
//                       child: Icon(
//                         widget.icons[index],
//                         color: Colors.grey.shade800,
//                         size: 26,
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:zentry/src/core/utils/app_colors.dart';

// class QuarterCircleMenu extends StatelessWidget {
//   final List<IconData> icons;
//   final VoidCallback onClose;
//   final Animation<double> animation;
//   final void Function(int index)? onIconTap;

//   const QuarterCircleMenu({
//     super.key,
//     required this.icons,
//     required this.onClose,
//     required this.animation,
//     this.onIconTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final int total = icons.length;

//     // Dynamic layer assignment
//     List<List<IconData>> layers;
//     if (total <= 5) {
//       // Use only one layer
//       layers = [icons];
//     } else {
//       // Split into two layers: half-1 in inner, half+1 in outer
//       final int innerCount = (total / 2).floor();
//       final int outerCount = total - innerCount;

//       final List<IconData> innerIcons = icons.sublist(0, innerCount);
//       final List<IconData> outerIcons = icons.sublist(innerCount);
//       layers = [innerIcons, outerIcons];
//     }

//     return Stack(
//       children: [
//         // Background
//         Positioned.fill(
//           child: GestureDetector(
//             onTap: onClose,
//             child: AnimatedBuilder(
//               animation: animation,
//               builder: (context, child) => Container(
//                 color: Colors.black.withOpacity(0.3 * animation.value),
//               ),
//             ),
//           ),
//         ),

//         // Icon layers
//         ...List.generate(layers.length, (layerIndex) {
//           final iconsInLayer = layers[layerIndex];

//           final double radius = 130 + (layerIndex * 80);
//           final double totalAngle = pi / 2;
//           final double paddingAngle = 10 * (pi / 180);
//           final double step = iconsInLayer.length == 1
//               ? 0
//               : (totalAngle - 2 * paddingAngle) / (iconsInLayer.length - 1);

//           return List.generate(iconsInLayer.length, (index) {
//             final double angle = (pi / 2) - paddingAngle - (index * step);
//             final double dx = cos(angle) * radius;
//             final double dy = sin(angle) * radius;

//             return AnimatedBuilder(
//               animation: animation,
//               builder: (context, child) {
//                 final curvedValue = Curves.easeOut.transform(animation.value);
//                 return Positioned(
//                   right: 16 + dx * curvedValue,
//                   bottom: 16 + dy * curvedValue,
//                   child: Transform.scale(
//                     scale: curvedValue,
//                     child: GestureDetector(
//                       onTap: () {
//                         onClose();
//                         if (onIconTap != null) {
//                           final globalIndex = (layerIndex == 0)
//                               ? index
//                               : layers[0].length + index;
//                           onIconTap!(globalIndex);
//                         }
//                       },
//                       child: Container(
//                         width: 48,
//                         height: 48,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: AppColors.peacefulSeaBlue.withOpacity(0.2),
//                               blurRadius: 6,
//                               offset: Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: Icon(
//                           iconsInLayer[index],
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           });
//         }).expand((i) => i).toList(),
//       ],
//     );
//   }
// }
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';
import 'package:zentry/src/core/utils/app_colors.dart';
// import 'package:zentry/src/features/appearance/domain/entities/appearance_settings.dart';

class QuarterCircleMenu extends ConsumerWidget {
  final List<IconData> icons;
  final VoidCallback onClose;
  final Animation<double> animation;
  final void Function(int index)? onIconTap;
  //final AppearanceSettings appearance;

  const QuarterCircleMenu({
    super.key,
    required this.icons,
    required this.onClose,
    required this.animation,
    // required this.appearance,
    this.onIconTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(appPaletteProvider);
    final int total = icons.length;

    // Dynamic layer assignment
    List<List<IconData>> layers;
    if (total < 5) {
      // One layer only
      layers = [icons];
    } else if (total > 9) {
      // Outer has 2 more icons than inner
      final int outerCount = ((total + 2) / 2).floor();
      final int innerCount = total - outerCount;

      final List<IconData> innerIcons = icons.sublist(0, innerCount);
      final List<IconData> outerIcons = icons.sublist(innerCount);
      layers = [innerIcons, outerIcons];
    } else {
      // Regular half split
      final int innerCount =
          total % 2 == 0 ? ((total) / 2).toInt() - 1 : (total / 2).toInt();
      //final int outerCount = total - innerCount;

      final List<IconData> innerIcons = icons.sublist(0, innerCount);
      final List<IconData> outerIcons = icons.sublist(innerCount);
      layers = [innerIcons, outerIcons];
    }

    return Stack(
      children: [
        // Background
        Positioned.fill(
          child: GestureDetector(
            onTap: onClose,
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) => Container(
                color:
                    palette.secondary.withValues(alpha: 0.3 * animation.value),
              ),
            ),
          ),
        ),

        // Icon layers
        ...List.generate(layers.length, (layerIndex) {
          final iconsInLayer = layers[layerIndex];

          final double radius = 130 + (layerIndex * 80);
          final double totalAngle = pi / 2;
          final double paddingAngle = 10 * (pi / 180);
          final double step = iconsInLayer.length == 1
              ? 0
              : (totalAngle - 2 * paddingAngle) / (iconsInLayer.length - 1);

          return List.generate(iconsInLayer.length, (index) {
            final double angle = (pi / 2) - paddingAngle - (index * step);
            final double dx = cos(angle) * radius;
            final double dy = sin(angle) * radius;

            return AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                final curvedValue = Curves.easeOut.transform(animation.value);
                return Positioned(
                  right: 16 + dx * curvedValue,
                  bottom: 16 + dy * curvedValue,
                  child: Transform.scale(
                    scale: curvedValue,
                    child: GestureDetector(
                      onTap: () {
                        onClose();
                        if (onIconTap != null) {
                          final globalIndex = (layerIndex == 0)
                              ? index
                              : layers[0].length + index;
                          onIconTap!(globalIndex);
                        }
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: palette.primary.withValues(alpha: 0.05),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: palette.primary.withValues(alpha: 0.7),
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Icon(
                          iconsInLayer[index],
                          color: palette.text.withValues(alpha: 0.8),
                          size: 26,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          });
        }).expand((i) => i).toList(),
      ],
    );
  }
}
