// Header widget showing current month and icons
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalenderViewHeader extends StatelessWidget {
  const CalenderViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final monthFormat = DateFormat.MMM();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            monthFormat.format(now),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.calendar_today, color: Colors.grey),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.grid_view, color: Colors.grey),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.grey),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
