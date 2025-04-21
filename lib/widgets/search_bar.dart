import 'package:flutter/material.dart';
import 'package:brain_buddy/config/app_color.dart';

Widget customSearchInput() {
  return TextField(
    style: TextStyle(color: AppColors.primary),
    decoration: InputDecoration(
      hintText: 'Search',
      hintStyle: TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      ),
      prefixIcon: Icon(Icons.search, color: AppColors.primary),
      filled: true,
      fillColor: Colors.white, // Background color inside input
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
