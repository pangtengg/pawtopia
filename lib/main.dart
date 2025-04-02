import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:paw/screens/donation_page.dart';
import 'screens/home_page.dart';
import 'screens/adoption_page.dart';
import 'screens/placeholder_page.dart';
import 'screens/community_page.dart'; 


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const PawtopiaApp());
}

class PawtopiaApp extends StatelessWidget {
  const PawtopiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/adoption': (context) => const AdoptionPage(),
        '/donation': (context) => const DonationPage(),
        '/clinic': (context) => const PlaceholderPage(title: 'Clinic & Shelter'),
        '/soulmate': (context) => const PlaceholderPage(title: 'Soulmate'),
        '/grid': (context) => const HomePage(),
        '/pets': (context) => const PlaceholderPage(title: 'Pets'),
        '/public': (context) => const CommunityPage(),
        '/profile': (context) => const PlaceholderPage(title: 'Profile'),
      },
    );
  }
}
