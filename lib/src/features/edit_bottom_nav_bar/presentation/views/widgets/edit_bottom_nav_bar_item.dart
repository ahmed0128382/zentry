import 'package:flutter/material.dart';

// class EditBottomNavBarItem extends StatelessWidget {
//   const EditBottomNavBarItem({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListTile(
//           leading: SizedBox(
//             width: 56,
//             child: Row(
//               children: [
//                 Icon(Icons.remove_circle, color: Colors.red),
//                 const SizedBox(width: 8),
//                 Icon(
//                   Icons.check_circle,
//                   color: Colors.green,
//                 ),
//               ],
//             ),
//           ),
//           title: const Text('Today'),
//           subtitle: const Text('Manage your Task  with Lists and Filters'),
//           trailing: Icon(
//             Icons.filter_list_outlined,
//           ),
//         ),
//       ),
//     );
//   }
// }

class TabBarSettingsPage extends StatelessWidget {
  const TabBarSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: const [
              _TabBarItem(
                icon: Icons.check_circle_outline,
                title: 'Task',
                subtitle: 'Manage your task with lists and filters.',
                isActive: true,
              ),
              _TabBarItem(
                icon: Icons.calendar_today,
                title: 'Calendar',
                subtitle: 'Manage your task with five calendar views.',
                isActive: false,
              ),
              _TabBarItem(
                icon: Icons.timer,
                title: 'Pomodoro',
                subtitle: 'Use the Pomo timer or stopwatch to keep focus.',
                isActive: false,
              ),
              _TabBarItem(
                icon: Icons.favorite_border,
                title: 'Habit Tracker',
                subtitle: 'Develop a habit and keep track of it.',
                isActive: false,
              ),
              _TabBarItem(
                icon: Icons.star_border,
                title: 'Countdown',
                subtitle: 'Remember every special day.',
                isActive: false,
              ),
              _TabBarItem(
                icon: Icons.search,
                title: 'Search',
                subtitle: 'Do a quick search easily.',
                isActive: false,
              ),
              _TabBarItem(
                icon: Icons.apps,
                title: 'Eisenhower Matrix',
                subtitle: 'Focus on what\'s important and urgent.',
                isActive: false,
              ),
              _TabBarItem(
                icon: Icons.settings,
                title: 'Settings',
                subtitle: 'Make changes to the current settings.',
                isActive: false,
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        const _MaxTabsSection(),
      ],
    );
  }
}

class _TabBarItem extends StatelessWidget {
  const _TabBarItem({
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

class _MaxTabsSection extends StatelessWidget {
  const _MaxTabsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      color: Colors.grey[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Max number of tabs',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Row(
            children: const [
              Text(
                '5',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
