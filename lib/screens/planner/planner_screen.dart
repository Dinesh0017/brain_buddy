import 'package:flutter/material.dart';
class PlannerScreen extends StatelessWidget {
  const PlannerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Study Planner")),
      body: const Center(child: Text("Planner goes here")),
    );
  }
}