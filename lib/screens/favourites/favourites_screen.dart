import 'package:brain_buddy/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:brain_buddy/widgets/main_screen_com.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> favoriteItems = [
      {
        'title': 'Motivational Quote',
        'subtitle': 'Believe in yourself!',
        'icon': Icons.star,
      },
      {
        'title': 'Workout Reminder',
        'subtitle': 'Leg day at 6 AM 💪',
        'icon': Icons.fitness_center,
      },
      {
        'title': 'Saved Note',
        'subtitle': 'Buy groceries: milk, bread, fruits',
        'icon': Icons.note,
      },
    ];

    return MainScreenCom(
      children: [
        const SizedBox(height: 20),
        const Text(
          'Favorites',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color:AppColors.primary),
        ),
        const SizedBox(height: 20),
        ...favoriteItems.map((item) => _buildFavoriteTile(item)).toList(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildFavoriteTile(Map<String, dynamic> item) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        leading: Icon(item['icon'], color: AppColors.secondary),
        title: Text(
          item['title'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(item['subtitle']),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
        },
      ),
    );
  }
}
