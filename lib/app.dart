import 'package:brain_buddy/screens/auth/login_screen.dart';
import 'package:brain_buddy/screens/auth/signup_login_screen.dart';
import 'package:brain_buddy/screens/auth/welcome_screen.dart';
import 'package:brain_buddy/screens/notes/notes_screen.dart';
import 'package:brain_buddy/screens/planner/planner_screen.dart';
import 'package:brain_buddy/screens/progress/progress_screen.dart';
import 'package:brain_buddy/screens/settings/settings_screen.dart';
import 'package:brain_buddy/screens/timer/timer_screen.dart';
import 'package:flutter/material.dart';
import 'config/app_theme.dart';
import 'screens/home/home_screen.dart';

class BrainBuddyApp extends StatelessWidget {
  const BrainBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen  (),
      routes: {
        '/planner': (context) => const PlannerScreen(),
        '/timer': (context) => const TimerScreen(),
        '/notes': (context) => const NotesScreen(),
        '/progress': (context) => const ProgressScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/home': (context) => const HomeScreen(),
        '/signup_login_screen': (context) => const SignUpLoginScreen(),
        '/login': (context) => const LoginScreen(),
        '/welcome': (context) => const WelcomeScreen(),

      },
    );
  }
}