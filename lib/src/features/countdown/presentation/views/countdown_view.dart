import 'package:flutter/material.dart';

class CountdownView extends StatelessWidget {
  const CountdownView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCountdownItem(
                  icon: Icons.hourglass_empty,
                  iconColor: Colors.blue,
                  title: 'Weekend',
                  days: 6,
                  isDaysLeft: true,
                ),
                const SizedBox(height: 16.0),
                _buildCountdownItem(
                  icon: Icons.celebration,
                  iconColor: Colors.pinkAccent,
                  title: 'New Year\'s Day',
                  days: 144,
                  isDaysLeft: true,
                ),
                const SizedBox(height: 16.0),
                _buildCountdownItem(
                  icon: Icons.check_box_outline_blank,
                  iconColor: Colors.lightGreen,
                  title: 'Use TickTick',
                  days: 11,
                  isDaysLeft: false,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: FloatingActionButton(
                heroTag: 'add_count_down',
                onPressed: () {
                  // Handle floating action button press
                },
                child: const Icon(Icons.add),
                backgroundColor: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required int days,
    required bool isDaysLeft,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24.0,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$days',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: iconColor,
                ),
              ),
              Text(
                isDaysLeft ? 'Days Left' : 'Days Since',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
