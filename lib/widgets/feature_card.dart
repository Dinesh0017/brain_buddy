import 'package:brain_buddy/config/app_color.dart';
import 'package:flutter/material.dart';

class FeatureCardGrid extends StatelessWidget {
  const FeatureCardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      {'icon': Icons.bar_chart, 'label': 'Progress', 'route': '/progress'},
      {'icon': Icons.calendar_today, 'label': 'Planner', 'route': '/planner'},
      {'icon': Icons.check_circle, 'label': 'Done', 'route': '/done'},
      {'icon': Icons.photo, 'label': 'Gallery', 'route': '/gallery'},
      {'icon': Icons.timer, 'label': 'Timer', 'route': '/timer'},
      {'icon': Icons.note, 'label': 'Notes', 'route': '/notes'},
    ];
    return GridView.count(
      padding: const EdgeInsets.all(16),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: features.map((feature) {
        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, feature['route']),
          child: _buildFeatureCard(feature['icon'], feature['label']),
        );
      }).toList(),
    );


  }

  Widget _buildFeatureCard(IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 60, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: Text('Progress Screen')));
}

class PlannerScreen extends StatelessWidget {
  const PlannerScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: Text('Planner Screen')));
}

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: Text('Done Screen')));
}

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: Text('Gallery Screen')));
}

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: Text('Timer Screen')));
}

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: Text('Notes Screen')));
}

class NextSubmitButton extends StatefulWidget {
  const NextSubmitButton({super.key});

  @override
  State<NextSubmitButton> createState() => _NextSubmitButtonState();
}

class _NextSubmitButtonState extends State<NextSubmitButton> {
  double progress = 0.0;

  void simulateProgress() {
    if (progress < 1.0) {
      setState(() {
        progress += 0.2;
        if (progress > 1.0) progress = 1.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: simulateProgress,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Next Submit',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.pink[100],
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                minHeight: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
