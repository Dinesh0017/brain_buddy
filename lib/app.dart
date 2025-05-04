import 'package:brain_buddy/config/app_color.dart';
import 'package:brain_buddy/screens/auth/login_screen.dart';
import 'package:brain_buddy/screens/auth/signup_login_screen.dart';
import 'package:brain_buddy/screens/auth/welcome_screen.dart';
import 'package:brain_buddy/screens/gallery/gallery_screen.dart';
import 'package:brain_buddy/screens/notes/notes_screen.dart';
import 'package:brain_buddy/screens/planner/planner_screen.dart';
import 'package:brain_buddy/screens/profile/profile_screen.dart';
import 'package:brain_buddy/screens/progress/progress_screen.dart';
import 'package:brain_buddy/screens/done/done_screen.dart';
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
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        // 👇 Add this to change cursor and selection handle colors
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.primary,               // Text cursor color
          selectionHandleColor: AppColors.primary,      // The purple circle handle
          selectionColor: Color(0x552196F3),            // Optional: selected text background
        ),
        // any other theme settings
      ),
      home: const HomeScreen  (),
      routes: {
        '/planner': (context) => const PlannerScreen(),
        '/timer': (context) => const TimerScreen(),
        '/notes': (context) => const NotesScreen(),
        '/progress': (context) => const ProgressScreen(),
        '/done': (context) => const DoneScreen(),
        '/home': (context) => const HomeScreen(),
        '/signup_login_screen': (context) => const SignUpLoginScreen(),
        '/login': (context) => const LoginScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/gallery': (context) => const GalleryScreen(),
        '/profile': (context) => const ProfileScreen(),

      },
    );
  }
}