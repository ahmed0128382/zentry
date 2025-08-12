import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AchievementScoreWidget extends StatelessWidget {
  const AchievementScoreWidget({super.key});

  Widget _bottomTitles(double value, TitleMeta meta) {
    switch (value.toInt()) {
      case 0:
        return const Text('4th');
      case 1:
        return const Text('5th');
      case 2:
        return const Text('6th');
      case 3:
        return const Text('7th');
      case 4:
        return const Text('8th');
      case 5:
        return const Text('9th');
      case 6:
        return const Text('Today');
      default:
        return const Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('63',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text('Achievement score',
                    style: TextStyle(color: Colors.grey[600])),
              ],
            ),
            const Text('Beginner',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: _bottomTitles,
                    interval: 1,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: const [
                    FlSpot(0, 2),
                    FlSpot(1, 3.5),
                    FlSpot(2, 4),
                    FlSpot(3, 3),
                    FlSpot(4, 5.5),
                    FlSpot(5, 6),
                    FlSpot(6, 8),
                  ],
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 4,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.blue.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
