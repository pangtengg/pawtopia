import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paw/screens/donation_page.dart';
import 'screens/home_page.dart';
import 'screens/adoption_page.dart';
import 'screens/placeholder_page.dart';
import 'screens/community_page.dart';
import 'screens/soulmate.dart';
import 'screens/login_page.dart';

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
      initialRoute: _initialRoute,
      routes: {
        '/login': (context) => const LoginPage(),
        '/': (context) => const HomePage(),
        '/adoption': (context) => const AdoptionPage(),
        '/donation': (context) => const DonationPage(),
        '/clinic': (context) => const PlaceholderPage(),
        '/grid': (context) => const HomePage(),
        '/pets': (context) => const AnimalSoulmateApp(),
        '/public': (context) => const CommunityPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }

  // Determine initial route based on authentication status
  String get _initialRoute {
    // Check if user is already logged in
    final currentUser = FirebaseAuth.instance.currentUser;
    return currentUser != null ? '/' : '/login';
  }
}

// Simple profile page that can access current user info
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: user?.photoURL != null 
                ? NetworkImage(user!.photoURL!) 
                : null,
              child: user?.photoURL == null 
                ? const Icon(Icons.person, size: 50) 
                : null,
            ),
            const SizedBox(height: 20),
            Text(
              user?.displayName ?? 'Pet Lover',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              user?.email ?? '',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            // Add more profile options here
          ],
        ),
      ),
    );
  }
}