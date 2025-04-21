import 'package:brain_buddy/config/app_color.dart';
import 'package:brain_buddy/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class MainScreenCom extends StatelessWidget {
  const MainScreenCom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        elevation: 0,
        toolbarHeight: 100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/logo/brain buddy.jpg',
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            Icon(Icons.menu, color: AppColors.primary, size: 30),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [customSearchInput(), const SizedBox(height: 20)],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: AppColors.primary,
            child: BottomNavigationBar(
              backgroundColor:
                  Colors.transparent,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_max_rounded,size: 40),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_none_rounded,size: 40),
                  label: 'Notifications',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outline,size: 40),
                  label: 'Add',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border,size: 40),
                  label: 'Favorites',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
