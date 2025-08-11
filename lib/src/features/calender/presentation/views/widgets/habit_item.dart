// Single habit item widget
import 'package:flutter/material.dart';
import 'package:zentry/src/core/utils/app_colors.dart';

class HabitItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String time;

  const HabitItem({
    required this.title,
    required this.icon,
    required this.time,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.peacefulSeaBlue),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(title)),
          Text(
            time,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.check_circle, color: Colors.grey),
        ],
      ),
    );
  }
}
