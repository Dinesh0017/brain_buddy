import 'package:brain_buddy/screens/planner/planner_screen.dart';
import 'package:flutter/material.dart';
import 'package:brain_buddy/config/app_color.dart';
import 'package:brain_buddy/widgets/main_screen_com.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> completedTasks = [
      "Assignment 01 Completed",
      "Assignment 02 Completed",
      "Group Project Submitted",
      "Reading Task Finished",
      "Quiz Preparation Done",
      "Assignment 02 Completed",
      "Group Project Submitted",
      "Reading Task Finished",
      "Quiz Preparation Done",
    ];

    return MainScreenCom(
      children: [
        const SizedBox(height: 20),
        const Text(
          "Completed Tasks 🎉",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ...completedTasks.map((task) => _buildDoneCard(task)).toList(),
        const SizedBox(height: 30),
        const Text(
          "You're smashing your goals!",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        _buildBackButton(context),
      ],
    );
  }

  Widget _buildDoneCard(String task) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: AppColors.secondary, size: 30),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              task,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
  Navigator.push(context, MaterialPageRoute(builder: (_) => PlannerScreen()));
},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(12),
          
        ),
        child: const Center(
          child: Text(
            'Go to Planner',
            style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary,fontSize: 18),
          ),
        ),
      ),
    );
  }
}
