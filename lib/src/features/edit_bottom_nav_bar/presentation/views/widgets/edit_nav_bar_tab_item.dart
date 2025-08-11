import 'package:flutter/material.dart';

class EditNavBarTabItem extends StatelessWidget {
  const EditNavBarTabItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isActive,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left icons column
          SizedBox(
            width: 60,
            child: Row(
              children: [
                Icon(
                  isActive ? Icons.remove_circle : Icons.add_circle,
                  color: isActive ? Colors.red : Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Icon(
                  icon,
                  color: isActive ? Colors.black : Colors.grey,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Title and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isActive ? Colors.black : Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isActive ? Colors.black54 : Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Trailing reorder icon
          IconButton(
            icon: const Icon(Icons.menu),
            color: Colors.grey,
            onPressed: () {
              // Handle drag/reorder
            },
          ),
        ],
      ),
    );
  }
}
