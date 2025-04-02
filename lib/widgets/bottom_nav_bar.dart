import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedFontSize: 16,
      unselectedFontSize: 14,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      iconSize: 32,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/grid');
            break;
          case 1:
            Navigator.pushNamed(context, '/pets');
            break;
          case 2:
            Navigator.pushNamed(context, '/public');
            break;
          case 3:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 4),
            child: Icon(Icons.grid_view, size: 30),
          ),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 4),
            child: Icon(Icons.pets, size: 30),
          ),
          label: 'Pets',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 4),
            child: Icon(Icons.public, size: 30),
          ),
          label: 'Community',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 4),
            child: Icon(Icons.person, size: 30),
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
