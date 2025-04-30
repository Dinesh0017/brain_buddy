// Inside your file where you use MainScreenCom

import 'package:brain_buddy/widgets/main_screen_com.dart';
import 'package:brain_buddy/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:brain_buddy/config/app_color.dart';


class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScreenCom(
      children: [
        customSearchInput(),
        const SizedBox(height: 20),
        NotificationsScren(),
      ],
    );
  }
}

// Notification content
class NotificationsScren extends StatelessWidget {
  const NotificationsScren({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(20, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.notifications, color: AppColors.secondary, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'This is notification ${index + 1}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
