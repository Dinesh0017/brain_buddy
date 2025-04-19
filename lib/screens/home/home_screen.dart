import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      {'title': 'Planner', 'icon': Icons.calendar_today, 'route': '/planner'},
      {'title': 'Focus Timer', 'icon': Icons.timer, 'route': '/timer'},
      {'title': 'Notes', 'icon': Icons.note_alt, 'route': '/notes'},
      {'title': 'Progress', 'icon': Icons.bar_chart, 'route': '/progress'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("BrainBuddy")),
      body: GridView.builder(
        padding: const EdgeInsets.all(24.0),
        itemCount: features.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          final feature = features[index];
          final String title = feature['title'] as String;
          final IconData icon = feature['icon'] as IconData;
          final String route = feature['route'] as String;

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, route),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.indigo[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 40, color: Colors.indigo),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
