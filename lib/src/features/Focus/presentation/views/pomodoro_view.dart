import 'package:flutter/material.dart';
import 'package:zentry/src/core/utils/app_colors.dart';

class PomodoroView extends StatelessWidget {
  const PomodoroView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            // "Focus" text with arrow icon
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Focus',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black.withValues(alpha: 0.8),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.black54,
                ),
              ],
            ),
            const SizedBox(height: 40),
            // Timer circle with time text
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black.withValues(alpha: 0.1),
                  width: 2,
                ),
              ),
              child: const Center(
                child: Text(
                  '25:00',
                  style: TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            // "Start" button
            ElevatedButton(
              onPressed: () {
                // Action to perform when button is pressed
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.peacefulSeaBlue,
                minimumSize: const Size(200, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Start',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
