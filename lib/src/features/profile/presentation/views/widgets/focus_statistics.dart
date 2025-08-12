import 'package:flutter/material.dart';
import 'package:zentry/src/features/profile/presentation/views/widgets/focus_text_stat.dart';

class FocusStatisticsWidget extends StatelessWidget {
  const FocusStatisticsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            FocusStat(label: 'Total Pomo', value: '0'),
            SizedBox(width: 16),
            FocusStat(label: 'Total Focus Duration', value: '0h 0m'),
          ],
        ),
        const SizedBox(height: 16),
        Center(
          child: Text('No Data', style: TextStyle(color: Colors.grey[600])),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Daily Average', style: TextStyle(color: Colors.grey[600])),
            Text('0m', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ],
    );
  }
}
