import 'package:flutter/material.dart';
import 'package:brain_buddy/config/app_color.dart';
import 'package:brain_buddy/widgets/custom_button.dart';

class SignUpLoginScreen extends StatelessWidget {
  const SignUpLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          // Top Content (Logo)
          Column(
            children: [
              const SizedBox(height: 150),
              Center(
                child: Image.asset(
                  'assets/logo/brain buddy.jpg',
                  height: 400,
                ),
              ),
            ],
          ),

          // Bottom White Container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Do You Have an Account...?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF2C0014),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // First Button
                  PrimaryButton(
                    text: 'Sign Up',
                    backgroundColor: AppColors.primary,
                    textColor: AppColors.textPrimary,
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                  ),
                  const SizedBox(height: 20),

                  const Center(
                    child: Text(
                      'Already have an account?',
                      style: TextStyle(color: Color(0xFF2C0014), fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Second Button
                  PrimaryButton(
                    text: 'Log In',
                    backgroundColor: AppColors.primary,
                    textColor: AppColors.textPrimary,
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
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
