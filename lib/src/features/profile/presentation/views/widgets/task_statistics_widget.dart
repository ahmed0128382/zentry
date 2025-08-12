import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TaskStatisticsWidget extends StatelessWidget {
  const TaskStatisticsWidget({super.key});

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
          children: [
            const Text('10',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Text('Total Completion', style: TextStyle(color: Colors.grey[600])),
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
                    FlSpot(0, 3),
                    FlSpot(1, 4),
                    FlSpot(2, 5),
                    FlSpot(3, 4),
                    FlSpot(4, 3),
                    FlSpot(5, 2),
                    FlSpot(6, 1),
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
