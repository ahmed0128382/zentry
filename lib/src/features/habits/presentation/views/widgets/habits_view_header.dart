import 'package:flutter/material.dart';

class HabitsViewHeader extends StatelessWidget {
  const HabitsViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Habit Tracker',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              IconButton(icon: const Icon(Icons.access_time), onPressed: () {}),
              IconButton(
                  icon: const Icon(Icons.bookmark_border), onPressed: () {}),
              IconButton(icon: const Icon(Icons.sort), onPressed: () {}),
            ],
          )
        ],
      ),
    );
  }
}
