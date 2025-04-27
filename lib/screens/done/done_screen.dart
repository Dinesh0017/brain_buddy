import 'package:brain_buddy/config/app_color.dart';
import 'package:brain_buddy/widgets/main_screen_com.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DoneScreen extends StatefulWidget {
  const DoneScreen({super.key});

  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  double overallProgress = 75; // Overall circular progress
  double assignmentProgress = 60; // Assignment bar
  double taskProgress = 80; // Task bar

  @override
  Widget build(BuildContext context) {
    return MainScreenCom(
      children: [
        const SizedBox(height: 20),
        _buildProgressCircle(overallProgress),
        const SizedBox(height: 20),
        const Text(
          'Progress Summary',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary),
        ),
        const SizedBox(height: 20),
        _buildProgressBar('Assignment Progress', assignmentProgress),
        const SizedBox(height: 10),
        _buildProgressBar('Task Progress', taskProgress),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: _buildCard(Icons.check_circle, '5 Tasks\nDone!', Colors.pink)),
            const SizedBox(width: 10),
            Expanded(child: _buildCard(Icons.emoji_events, 'First Assignment\nCompleted!', Colors.amber)),
          ],
        ),
        const SizedBox(height: 20),
        _buildMotivationalCard(),
        const SizedBox(height: 20),
        _buildLineChart(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildProgressCircle(double percent) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.secondary.withOpacity(0.3),
      ),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              value: percent / 100,
              strokeWidth: 14,
              backgroundColor: Colors.pink[100],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${percent.toInt()}%',
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const Text(
                  'Completed',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(String title, double value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white)),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: value / 100,
                    color: Colors.pinkAccent,
                    backgroundColor: Colors.pink[100],
                    minHeight: 8,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Text(
              '${value.toInt()}%',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(IconData icon, String text, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 30),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMotivationalCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Text(
          "You're doing great! Keep it up!",
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildLineChart() {
    return SizedBox(
      height: 150,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  List<String> days = ["S", "M", "T", "W", "T", "F", "S"];
                  int index = value.toInt();
                  if (index < 0 || index >= days.length) {
                    return const SizedBox.shrink();
                  }
                  return Text(
                    days[index],
                    style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 10,
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              spots: [
                FlSpot(0, 4),
                FlSpot(1, 6),
                FlSpot(2, 5),
                FlSpot(3, 7),
                FlSpot(4, 6),
                FlSpot(5, 8),
                FlSpot(6, 9),
              ],

              barWidth: 4,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(show: false),
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
