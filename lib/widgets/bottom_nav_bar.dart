import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
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
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.pets), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
      ],
    );
  }
}
