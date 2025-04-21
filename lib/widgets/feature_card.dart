import 'package:brain_buddy/config/app_color.dart';
import 'package:flutter/material.dart';

class FeatureCardGrid extends StatelessWidget {
  const FeatureCardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(16),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // if inside another scroll view
      children: [
        _buildFeatureCard(Icons.bar_chart, 'Progress'),
        _buildFeatureCard(Icons.calendar_today, 'Planner'),
        _buildFeatureCard(Icons.check_circle, 'Done'),
        _buildFeatureCard(Icons.photo, 'Gallery'),
        _buildFeatureCard(Icons.timer, 'Timer'),
        _buildFeatureCard(Icons.note, 'Notes'),
        _buildFeatureCard(Icons.bar_chart, 'Progress'),
        _buildFeatureCard(Icons.calendar_today, 'Planner'),
        
      ],
    );
  }

  Widget _buildFeatureCard(IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.5) ,
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
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
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
