import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/bottom_nav_bar.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final CollectionReference organizations =
  FirebaseFirestore.instance.collection('organizations');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD0CFF8), Color(0xFFC4E1FB)],
          ),
        ),
        child: StreamBuilder(
          stream: organizations.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No organizations available"));
            }
            return ListView(
              padding: const EdgeInsets.all(10),
              children: snapshot.data!.docs.map((doc) {
                var data = doc.data() as Map<String, dynamic>;
                return OrganizationCard(
                  name: data['name'],
                  address: data['address'],
                  phone: data['phone'],
                  website: data['website'],
                );
              }).toList(),
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class OrganizationCard extends StatelessWidget {
  final String name, address, phone, website;

  const OrganizationCard({
    super.key,
    required this.name,
    required this.address,
    required this.phone,
    required this.website,
  });

  Future<void> _launchURL() async {
    String urlString = website.startsWith('http') ? website : 'https://$website';
    final Uri url = Uri.parse(urlString);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $urlString');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      child: ListTile(
        leading: const Icon(Icons.pets, size: 40, color: Colors.purple),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(address, style: const TextStyle(color: Colors.grey)),
            Text(phone, style: const TextStyle(color: Colors.grey)),
            GestureDetector(
              onTap: _launchURL,
              child: Text(website, style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.purple),
        onTap: _launchURL,
      ),
    );
  }
}


