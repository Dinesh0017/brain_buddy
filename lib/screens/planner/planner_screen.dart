import 'package:brain_buddy/config/app_color.dart';
import 'package:brain_buddy/widgets/main_screen_com.dart';
import 'package:brain_buddy/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({super.key});

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  int selectedDate = 18;
  Map<int, List<String>> tasksByDate = {
    18: ["Assignment 01", "Assignment 02"],
  };

  void _onDateSelected(int date) {
    setState(() {
      selectedDate = date;
    });
  }

  void _addTask() {
    setState(() {
      tasksByDate.putIfAbsent(selectedDate, () => []).add("New Task on $selectedDate");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenCom(
      children: [
        const SizedBox(height: 20),
        customSearchInput(),
        const SizedBox(height: 20),
        _buildCalendar(selectedDate, _onDateSelected),
        const SizedBox(height: 20),
        _buildAddTaskButton(_addTask),
        const SizedBox(height: 16),
        ..._buildTaskCards(tasksByDate[selectedDate] ?? []),
      ],
    );
  }
}

Widget _buildCalendar(int selectedDate, Function(int) onDateSelected) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.secondary.withOpacity(0.5),
      borderRadius: BorderRadius.circular(16),
    ),
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(Icons.arrow_back_ios_new, color: AppColors.primary),
            Text(
              'January',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
            Icon(Icons.arrow_forward_ios, color: AppColors.primary),
          ],
        ),
        const SizedBox(height: 10),
        // Weekdays
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
              .map((day) => Expanded(
                    child: Center(
                      child: Text(day, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 10),
        // Dates
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(31, (index) {
            int day = index + 1;
            bool isSelected = day == selectedDate;
            return GestureDetector(
              onTap: () => onDateSelected(day),
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.pink[600] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$day',
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    ),
  );
}


Widget _buildAddTaskButton(VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.pink[600],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.pink[100]!),
      ),
      child: const Center(
        child: Text(
          'Add New Task',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    ),
  );
}


List<Widget> _buildTaskCards(List<String> tasks) {
  return tasks.map((title) => _buildTaskCard(title)).toList();
}
Widget _buildTaskCard(String title) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.secondary.withOpacity(0.5),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        IconButton(
          icon: const Icon(Icons.check_circle, color: Colors.green),
          onPressed: () {},
        ),
      ],
    ),
  );
}
