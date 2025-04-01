import 'package:flutter/material.dart';
import '../models/pet_model.dart';

class PetCard extends StatelessWidget {
  final Pet pet;
  final VoidCallback onTap;

  const PetCard({required this.pet, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Pet Image - Adjusted size
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                pet.imagePath,
                height: 165, // Increased for better visibility
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 4),
            // Pet Name - Adjusted size
            Text(
              pet.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14, // Further decreased size
              ),
            ),
            const SizedBox(height: 3),
            // Pet Details: Age + Gender, Location in the same row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildInfoTagWithIcon(pet.age, pet.sex == "Male" ? Icons.male : Icons.female, Colors.purple),
                const SizedBox(width: 6),
                _buildInfoTag(pet.location, Icons.location_on),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Reusable function to build each tag
  Widget _buildInfoTag(String text, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3), // Further decreased padding
      decoration: BoxDecoration(
        color: Color(0xFFD0CFF8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: Colors.white), // Further decreased icon size
          const SizedBox(width: 2),
          Text(
            text,
            style: const TextStyle(fontSize: 8, color: Colors.white), // Further decreased text size
          ),
        ],
      ),
    );
  }

  // Function to build age tag with gender icon
  Widget _buildInfoTagWithIcon(String text, IconData icon, Color iconColor) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3), // Further decreased padding
      decoration: BoxDecoration(
        color: Color(0xFFD0CFF8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cake, size: 10, color: Colors.white), // Further decreased icon size
          const SizedBox(width: 2),
          Text(
            text,
            style: const TextStyle(fontSize: 8, color: Colors.white), // Further decreased text size
          ),
          const SizedBox(width: 4),
          Icon(icon, size: 10, color: iconColor), // Further decreased gender icon size
        ],
      ),
    );
  }
}
