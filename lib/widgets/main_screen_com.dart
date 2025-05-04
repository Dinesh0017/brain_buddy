import 'package:brain_buddy/config/app_color.dart';
import 'package:brain_buddy/screens/favourites/favourites_screen.dart';
import 'package:brain_buddy/screens/home/home_screen.dart';
import 'package:brain_buddy/screens/notifications/notifications_screen.dart';
import 'package:brain_buddy/screens/planner/planner_screen.dart';
import 'package:brain_buddy/screens/profile/profile_screen.dart';

import 'package:flutter/material.dart';

class MainScreenCom extends StatefulWidget {
  final List<Widget> children;

  const MainScreenCom({super.key, required this.children});

  @override
  _MainScreenComState createState() => _MainScreenComState();
}

class _MainScreenComState extends State<MainScreenCom> {
  int _currentIndex = 0; // Track the selected index

  // Method to navigate to the respective page based on the index
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navigate to different screens based on the index
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => NotificationsScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PlannerScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => FavoriteScreen()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        elevation: 0,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.primary,
                size: 40,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/logo/brain buddy.jpg',
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.children,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: AppColors.primary,
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              onTap: _onItemTapped, // Handle item tap
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_max_rounded, size: 40),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_none_rounded, size: 40),
                  label: 'Notifications',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outline, size: 40),
                  label: 'Add',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border, size: 40),
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
