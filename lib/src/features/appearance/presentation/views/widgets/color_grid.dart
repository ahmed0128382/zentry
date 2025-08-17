// import 'package:flutter/material.dart';
// import 'package:zentry/src/features/appearance/presentation/views/widgets/color_option.dart';

// class ColorGrid extends StatelessWidget {
//   const ColorGrid({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       crossAxisCount: 4, // keep 4 per row
//       crossAxisSpacing: 8.0, // tighter horizontal spacing
//       mainAxisSpacing: 8.0, // tighter vertical spacing
//       childAspectRatio: 0.85, // more balanced height for text + color box
//       children: const [
//         ColorOption(color: Colors.blue, label: 'Default', isSelected: true),
//         ColorOption(color: Colors.cyan, label: 'Teal'),
//         ColorOption(color: Colors.greenAccent, label: 'Turquoise'),
//         ColorOption(color: Colors.lightGreen, label: 'Matcha'),
//         ColorOption(color: Colors.amber, label: 'Sunshine'),
//         ColorOption(color: Colors.pinkAccent, label: 'Peach'),
//         ColorOption(color: Colors.purpleAccent, label: 'Lilac'),
//         ColorOption(color: Colors.white, label: 'Pearl', hasBadge: true),
//         ColorOption(color: Colors.grey, label: 'Pebble'),
//         ColorOption(
//             color: Colors.deepOrange, label: 'Dark Orange', hasBadge: true),
//         ColorOption(
//           color: Colors.blueAccent,
//           label: 'Material You',
//           hasBadge: true,
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:zentry/src/features/appearance/presentation/views/widgets/color_option.dart';

class ColorGrid extends StatelessWidget {
  final int selectedColor;
  final ValueChanged<int> onColorSelected;

  const ColorGrid({
    super.key,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    final options = const [
      ColorOption(color: 0xFF2196F3, label: 'Default'),
      ColorOption(color: 0xFF00BCD4, label: 'Teal'),
      ColorOption(color: 0xFF69F0AE, label: 'Turquoise'),
      ColorOption(color: 0xFF8BC34A, label: 'Matcha'),
      ColorOption(color: 0xFFFFC107, label: 'Sunshine'),
      ColorOption(color: 0xFFFF4081, label: 'Peach'),
      ColorOption(color: 0xFFE040FB, label: 'Lilac'),
      ColorOption(color: 0xFFFFFFFF, label: 'Pearl', hasBadge: true),
      ColorOption(color: 0xFF9E9E9E, label: 'Pebble'),
      ColorOption(color: 0xFFFF5722, label: 'Dark Orange', hasBadge: true),
      ColorOption(color: 0xFF448AFF, label: 'Material You', hasBadge: true),
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
      childAspectRatio: 0.85,
      children: options.map((opt) {
        return GestureDetector(
          onTap: () => onColorSelected(opt.color),
          child: ColorOption(
            color: opt.color,
            label: opt.label,
            hasBadge: opt.hasBadge,
            isSelected: selectedColor == opt.color,
          ),
        );
      }).toList(),
    );
  }
}
