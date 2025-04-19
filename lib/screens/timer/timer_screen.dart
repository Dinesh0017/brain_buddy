import 'package:flutter/material.dart';
class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Focus Timer")),
      body: const Center(child: Text("Timer goes here")),
    );
  }
}