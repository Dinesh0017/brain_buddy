import 'package:brain_buddy/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:brain_buddy/config/app_color.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          /// Top Content (Logo)
          Column(
            children: [
              const SizedBox(height: 150),
              Center(
                child: Image.asset('assets/logo/brain buddy.jpg', height: 400),
              ),
            ],
          ),

          /// Bottom White Container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 350,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Welcome To\nBrainBuddy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your smart study partner for better \nfocus, planning, and progress. \nStay organized, beat \nprocrastination, and make every \nminute count.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    text: 'Get Started',
                    backgroundColor: AppColors.primary,
                    textColor: AppColors.textPrimary,
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup-login');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
