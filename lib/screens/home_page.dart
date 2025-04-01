import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  static const List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.home, 'text': 'Adoption', 'route': '/adoption'},
    {'icon': Icons.card_giftcard, 'text': 'Donation', 'route': '/donation'},
    {'icon': Icons.location_on, 'text': 'Clinic & Shelter', 'route': '/clinic'},
    {'icon': Icons.pets, 'text': 'Soulmate', 'route': '/soulmate'},
  ];

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD0CFF8), Color(0xFFC4E1FB)],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Pawtopia",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        leading: Icon(menuItems[index]['icon'], size: 32),
                        title: Text(
                          menuItems[index]['text'],
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.pushNamed(context, menuItems[index]['route']);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const BottomNavBar(), // Calls bottom navigation bar widget
          ],
        ),
      ),
    );
  }
}
