import 'package:flutter/material.dart';
import 'package:zentry/src/features/Focus/presentation/views/pomodoro_view.dart';
import 'package:zentry/src/features/Focus/presentation/views/stop_watch_view.dart';

class FocusView extends StatefulWidget {
  const FocusView({super.key});

  @override
  State<FocusView> createState() => _FocusViewState();
}

class _FocusViewState extends State<FocusView> {
  bool showPomodoro = true; // true = Pomodoro, false = Stopwatch

  void toggleView(bool showPomodoroSelected) {
    if (showPomodoro != showPomodoroSelected) {
      setState(() {
        showPomodoro = showPomodoroSelected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Tab headers
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              children: [
                // Tabs section
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: _buildHeaderTab('Pomo', isSelected: showPomodoro,
                            onTap: () {
                          toggleView(true);
                        }),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: _buildHeaderTab('Stopwatch',
                            isSelected: !showPomodoro, onTap: () {
                          toggleView(false);
                        }),
                      ),
                    ],
                  ),
                ),
                // Icon buttons section
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon:
                          const Icon(Icons.timer_outlined, color: Colors.black),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, color: Colors.black),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert, color: Colors.black),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: showPomodoro ? const PomodoroView() : const StopWatchView(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderTab(String title,
      {required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: Colors.black.withValues(alpha: isSelected ? 0.8 : 0.4),
        ),
      ),
    );
  }
}

// Your PomodoroView and StopWatchView widgets go here as-is (unchanged).
