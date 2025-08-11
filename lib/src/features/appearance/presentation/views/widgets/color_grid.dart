import 'package:flutter/material.dart';
import 'package:zentry/src/features/appearance/presentation/views/widgets/color_option.dart';

class ColorGrid extends StatelessWidget {
  const ColorGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4, // keep 4 per row
      crossAxisSpacing: 8.0, // tighter horizontal spacing
      mainAxisSpacing: 8.0, // tighter vertical spacing
      childAspectRatio: 0.85, // more balanced height for text + color box
      children: const [
        ColorOption(color: Colors.blue, label: 'Default', isSelected: true),
        ColorOption(color: Colors.cyan, label: 'Teal'),
        ColorOption(color: Colors.greenAccent, label: 'Turquoise'),
        ColorOption(color: Colors.lightGreen, label: 'Matcha'),
        ColorOption(color: Colors.amber, label: 'Sunshine'),
        ColorOption(color: Colors.pinkAccent, label: 'Peach'),
        ColorOption(color: Colors.purpleAccent, label: 'Lilac'),
        ColorOption(color: Colors.white, label: 'Pearl', hasBadge: true),
        ColorOption(color: Colors.grey, label: 'Pebble'),
        ColorOption(
            color: Colors.deepOrange, label: 'Dark Orange', hasBadge: true),
        ColorOption(
          color: Colors.blueAccent,
          label: 'Material You',
          hasBadge: true,
        ),
      ],
    );
  }
}
