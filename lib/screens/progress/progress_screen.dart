import 'package:brain_buddy/config/app_color.dart';
import 'package:brain_buddy/widgets/main_screen_com.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // <- Don't forget to add fl_chart in pubspec.yaml

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  double overallProgress = 0.7;
  double assignmentProgress = 0.6;
  double taskProgress = 0.8;
  int tasksDone = 5;
  bool firstAssignmentCompleted = true;

  List<double> weeklyProgress = [0.3, 0.4, 0.35, 0.5, 0.45, 0.6, 0.7];

  @override
  Widget build(BuildContext context) {
    return MainScreenCom(
      children: [
        const SizedBox(height: 20),
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: CircularProgressIndicator(
                  value: overallProgress,
                  strokeWidth: 12,
                  backgroundColor: AppColors.secondary.withOpacity(0.3),
                  color: Colors.pinkAccent,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${(overallProgress * 100).toInt()}%",
                    style: const TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                    ),
                  ),
                  const Text(
                    "Completed",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),

        const Text(
          "Progress Summary",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 20),

        // Assignment Progress
        _buildProgressRow("Assignment Progress", assignmentProgress),

        const SizedBox(height: 16),

        // Task Progress
        _buildProgressRow("Task Progress", taskProgress),

        const SizedBox(height: 20),

        // Small Cards
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSmallCard(
              icon: Icons.check_circle,
              label: "$tasksDone Tasks\nDone!",
              color: AppColors.secondary,
            ),
            _buildSmallCard(
              icon: Icons.emoji_events,
              label: "First\nAssignment\nCompleted!",
              color: Colors.amber,
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Line Chart
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.secondary.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "You're doing great! Keep it up!",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval:1,
                          getTitlesWidget: (value, meta) {
                            const days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
                            if (value.toInt() >= 0 &&
                                value.toInt() < days.length) {
                              return Text(
                                days[value.toInt()],
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                          reservedSize: 22,
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
                        spots: List.generate(
                          weeklyProgress.length,
                          (index) =>
                              FlSpot(index.toDouble(), weeklyProgress[index]),
                        ),
                        isCurved: true,
                        color: AppColors.secondary,
                        barWidth: 4,
                        dotData: FlDotData(show: true),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressRow(String title, double progress) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress,
                  color: Colors.pinkAccent,
                  backgroundColor: Colors.white24,
                  minHeight: 8,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Text(
              "${(progress * 100).toInt()}%",
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallCard({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 50),
            const SizedBox(width: 10),
            Text(
              label,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
