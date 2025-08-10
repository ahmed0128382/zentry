import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildHeader(context),
              const SizedBox(height: 16),
              _buildSection(
                context,
                title: 'My Badges',
                content: _buildBadges(),
                showArrow: true,
              ),
              const SizedBox(height: 16),
              _buildSection(
                context,
                title: 'My Achievement Score',
                content: _buildAchievementScore(context),
                showArrow: true,
              ),
              const SizedBox(height: 16),
              _buildSection(
                context,
                title: 'Task Statistics',
                content: _buildTaskStatistics(context),
                showArrow: true,
              ),
              const SizedBox(height: 16),
              _buildSection(
                context,
                title: 'Focus Statistics',
                content: _buildFocusStatistics(context),
                showArrow: true,
              ),
              const SizedBox(height: 16),
              _buildSection(
                context,
                title: 'Weekly Habit Status',
                content: _buildWeeklyHabitStatus(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                  'http://googleusercontent.com/file_content/0'), // Replace with a valid image URL or asset
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'أحمد إبراهيم أب',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Upgrade to Premium',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ],
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required Widget content,
    bool showArrow = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (showArrow)
                const Icon(Icons.arrow_forward_ios,
                    size: 16, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  Widget _buildBadges() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildBadgeItem(label: '3'),
        _buildBadgeItem(label: '2'),
        _buildBadgeItem(label: '2'),
        _buildBadgeItem(label: '2'),
        _buildBadgeItem(label: '1'),
        _buildBadgeItem(label: '1'),
      ],
    );
  }

  Widget _buildBadgeItem({required String label}) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.yellow.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.yellow, width: 2),
          ),
          child: const Icon(Icons.star, color: Colors.yellow, size: 30),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(label, style: const TextStyle(fontSize: 12)),
        ),
      ],
    );
  }

  Widget _buildAchievementScore(BuildContext context) {
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
                    getTitlesWidget: (value, meta) {
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
                    },
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
                  spots: [
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

  Widget _buildTaskStatistics(BuildContext context) {
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
                    getTitlesWidget: (value, meta) {
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
                    },
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

  Widget _buildFocusStatistics(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildFocusStat(label: 'Total Pomo', value: '0'),
            const SizedBox(width: 16),
            _buildFocusStat(label: 'Total Focus Duration', value: '0h 0m'),
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

  Widget _buildFocusStat({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600])),
        Text(value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildWeeklyHabitStatus(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('13',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Text('Weekly Check-ins', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildHabitDay('Mon', 1.0, Colors.blue),
            _buildHabitDay('Tue', 0.8, Colors.blue),
            _buildHabitDay('Wed', 0.6, Colors.blue),
            _buildHabitDay('Thu', 0.0, Colors.grey),
            _buildHabitDay('Fri', 0.0, Colors.grey),
            _buildHabitDay('Sat', 0.0, Colors.grey),
            _buildHabitDay('Sun', 0.0, Colors.grey),
          ],
        ),
      ],
    );
  }

  Widget _buildHabitDay(String day, double progress, Color color) {
    return Column(
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 4,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            backgroundColor: Colors.grey.shade200,
          ),
        ),
        const SizedBox(height: 8),
        Text(day),
      ],
    );
  }
}
