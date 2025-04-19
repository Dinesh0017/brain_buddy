import 'package:brain_buddy/config/app_color.dart';
import 'package:brain_buddy/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          /// Scrollable form content
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 200,
              bottom: 250, // space for logo
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 24),
                _buildTextField('First Name'),
                const SizedBox(height: 16),
                _buildTextField('Last Name'),
                const SizedBox(height: 16),
                _buildTextField('Email'),
                const SizedBox(height: 16),
                _buildTextField('Password', obscure: true),
                const SizedBox(height: 16),
                _buildTextField('Confirm Password', obscure: true),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildTextField('Phone')),
                    const SizedBox(width: 16),
                    Expanded(child: _buildTextField('Age')),
                  ],
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  text: 'Submit',
                  backgroundColor: AppColors.background,
                  textColor: AppColors.primary,
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup-login');
                  },
                ),
              ],
            ),
          ),

          /// Fixed logo in the bottom right corner (always stays)
          Positioned(
            bottom: 10,
            right: 10,
            child: IgnorePointer( // avoids click interference
              child: Image.asset(
                'assets/logo/brain buddy.jpg',
                height: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, {bool obscure = false}) {
    return TextField(
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
