import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  String selectedCategory = 'Upcoming';
  bool isSearching = false;
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final Map<String, List<CampaignEvent>> categorizedCampaigns = {
    'Upcoming': [
      CampaignEvent(
        id: 'ev1',
        title: 'Volunteer at MareCet',
        description:
            'Join MareCet marine conservation efforts to protect Malaysia marine mammals. Activities include beach cleanups, data collection, and educational outreach. Suitable for all ages and experience levels. Training will be provided.',
        imageUrl: 'assets/images/marecet.jpg',
        date: 'Every Saturday, 9:00 AM - 4:00 PM',
        location: 'MareCet Research Center, Port Dickson, Malaysia',
        contact: 'info@marecet.org | +60 12-345-6789',
        organizer: 'MareCet Marine Conservation',
        petTypes: ['Marine Wildlife'],
        requirements:
            'Bring sunscreen, hat, water bottle, and comfortable clothes. No prior experience needed.',
        capacity: 20,
        currentParticipants: 12,
        isVirtual: false,
      ),
      CampaignEvent(
        id: 'ev2',
        title: 'Zoo Negara One-Day Volunteer Program',
        description:
            'Assist zookeepers in preparing food, cleaning enclosures, and creating enrichment activities for the animals. Learn about wildlife conservation while contributing to animal welfare at Malaysia national zoo.',
        imageUrl: 'assets/images/zoo_negara.jpg',
        date: 'First Sunday of each month, 8:00 AM - 3:00 PM',
        location: 'Zoo Negara, Hulu Kelang, Ampang, Selangor',
        contact: 'volunteer@zoonegara.org | +60 3-4108-3422',
        organizer: 'Zoo Negara Malaysia',
        petTypes: ['Wildlife', 'Exotic Animals'],
        requirements:
            'Age 18+, closed-toe shoes, comfortable clothes. Basic training provided on site.',
        capacity: 30,
        currentParticipants: 22,
        isVirtual: false,
      ),
      CampaignEvent(
        id: 'ev3',
        title: 'SPCA Vaccination Drive',
        description:
            'Free and low-cost vaccinations for dogs and cats from low-income households. Rabies, distemper, and parvovirus vaccines available. Registration required with proof of income and pet ownership.',
        imageUrl: 'assets/images/spca_vax.jpg',
        date: 'April 15, 2025, 10:00 AM - 3:00 PM',
        location: 'SPCA Selangor, Ampang Jaya',
        contact: 'healthcare@spca.org.my | +60 3-4256-5312',
        organizer: 'SPCA Selangor',
        petTypes: ['Dogs', 'Cats'],
        requirements:
            'Bring pet in carrier or on leash, vaccination records if available',
        capacity: 100,
        currentParticipants: 45,
        isVirtual: false,
      ),
      CampaignEvent(
        id: 'ev4',
        title: 'Pet First Aid Workshop',
        description:
            'Learn essential first aid skills for pets including wound care, CPR, heat stroke management, and how to recognize emergency situations. Hands-on practice with mannequins provided.',
        imageUrl: 'assets/images/pet_first_aid.jpg',
        date: 'April 20, 2025, 1:00 PM - 5:00 PM',
        location: 'PetLovers Community Center, Kuala Lumpur',
        contact: 'training@petlovers.com.my | +60 17-876-5432',
        organizer: 'PetLovers Malaysia & Malaysian Veterinary Association',
        petTypes: ['Dogs', 'Cats', 'Small Pets'],
        requirements: 'Notebook, no pets please',
        capacity: 40,
        currentParticipants: 28,
        isVirtual: false,
      ),
      CampaignEvent(
        id: 'ev5',
        title: 'Online Pet Behavior Seminar',
        description:
            'Virtual seminar on understanding and managing common behavioral issues in pets. Topics include separation anxiety, aggression, house soiling, and positive reinforcement training methods.',
        imageUrl: 'assets/images/behavior_seminar.jpg',
        date: 'April 25, 2025, 7:00 PM - 9:00 PM',
        location: 'Online via Zoom',
        contact: 'education@pawsitive.org | +60 19-765-4321',
        organizer: 'Pawsitive Training Malaysia',
        petTypes: ['Dogs', 'Cats'],
        requirements: 'Stable internet connection, Zoom account',
        capacity: 200,
        currentParticipants: 87,
        isVirtual: true,
      ),
    ],
    'Seasonal': [
      CampaignEvent(
        id: 'ev6',
        title: 'HOPE Animal Rescue Holiday Drive',
        description:
            'Annual holiday donation drive collecting food, bedding, toys, and medical supplies for rescued animals. Volunteer opportunities include sorting donations, shelter maintenance, and animal socialization. Special adoption promotions available throughout the event.',
        imageUrl: 'assets/images/hope.jpg',
        date: 'December 20-25, 2025, 10:00 AM - 8:00 PM daily',
        location: 'HOPE Johor Shelter, Johor Bahru',
        contact: 'contact@hopeanimalrescue.org | +60 7-223-4567',
        organizer: 'HOPE Animal Rescue',
        petTypes: ['Dogs', 'Cats', 'Small Animals'],
        requirements:
            'Donations welcome: pet food, toys, bedding, cleaning supplies',
        capacity: 50,
        currentParticipants: 12,
        isVirtual: false,
      ),
      CampaignEvent(
        id: 'ev7',
        title: 'Raya Pet Safety Awareness Campaign',
        description:
            'Educational campaign on keeping pets safe during Hari Raya celebrations. Topics include food hazards, managing anxiety from fireworks and visitors, and proper identification in case pets escape during festivities.',
        imageUrl: 'assets/images/raya_pets.jpg',
        date: 'Two weeks before Hari Raya, various times',
        location: 'Shopping malls across Kuala Lumpur and online',
        contact: 'safety@malaysiapets.org | +60 3-9876-5432',
        organizer: 'Malaysian Pet Safety Association',
        petTypes: ['All Pets'],
        requirements: 'None - open to all pet owners and the public',
        capacity: 0,
        currentParticipants: 0,
        isVirtual: true,
      ),
      CampaignEvent(
        id: 'ev8',
        title: 'Monsoon Season Pet Rescue Preparation',
        description:
            'Training workshop on preparing for pet emergencies during Malaysia\'s monsoon season. Learn about evacuation planning, emergency kits, temporary housing options, and coordination with relief agencies.',
        imageUrl: 'assets/images/monsoon_prep.jpg',
        date: 'October 10, 2025, 1:00 PM - 4:00 PM',
        location: 'Petaling Jaya Community Hall',
        contact: 'disaster@petrelief.org.my | +60 12-876-5432',
        organizer: 'Pet Emergency Relief Network Malaysia',
        petTypes: ['All Pets'],
        requirements: 'Registration required, one representative per household',
        capacity: 75,
        currentParticipants: 22,
        isVirtual: false,
      ),
    ],
    'Past': [
      CampaignEvent(
        id: 'ev9',
        title: 'World Animal Day Celebration',
        description:
            'A nationwide celebration featuring educational booths, adoption drives, pet health checkups, and family-friendly activities. The event raised awareness about animal welfare issues and promoted responsible pet ownership across Malaysia.',
        imageUrl: 'assets/images/world_animal_day.jpg',
        date: 'October 4, 2024',
        location: 'Nationwide at multiple venues',
        contact: 'info@worldanimalday.org.my | +60 3-2345-6789',
        organizer: 'Malaysian Animal Welfare Coalition',
        petTypes: ['All Animals'],
        requirements: 'N/A (Past Event)',
        capacity: 5000,
        currentParticipants: 4200,
        isVirtual: false,
      ),
      CampaignEvent(
        id: 'ev10',
        title: 'TNR (Trap-Neuter-Return) Workshop',
        description:
            'Intensive workshop on humane management of community cat populations. Participants learned trapping techniques, working with veterinarians, recovery care, and community engagement strategies.',
        imageUrl: 'assets/images/tnr_workshop.jpg',
        date: 'February 12, 2025',
        location: 'KL Cat Society Headquarters, Kuala Lumpur',
        contact: 'tnr@klcats.org | +60 3-7654-3210',
        organizer: 'KL Cat Society & Malaysian Veterinary Association',
        petTypes: ['Cats'],
        requirements: 'N/A (Past Event)',
        capacity: 30,
        currentParticipants: 30,
        isVirtual: false,
      ),
      CampaignEvent(
        id: 'ev11',
        title: 'Pet Photography Masterclass',
        description:
            'Professional photographers taught pet owners techniques for capturing beautiful portraits of their furry companions. Topics included lighting, composition, working with treats, action shots, and basic photo editing.',
        imageUrl: 'assets/images/pet_photography.jpg',
        date: 'March 5, 2025',
        location: 'Fotohub Studio, Bangsar, Kuala Lumpur',
        contact: 'events@fotohub.com.my | +60 3-2222-3333',
        organizer: 'Fotohub & Pet Lovers Malaysia',
        petTypes: ['All Pets'],
        requirements: 'N/A (Past Event)',
        capacity: 25,
        currentParticipants: 23,
        isVirtual: false,
      ),
    ],
  };

  List<CampaignEvent> get filteredCampaigns {
    if (searchQuery.isEmpty) {
      return categorizedCampaigns[selectedCategory] ?? [];
    }

    final query = searchQuery.toLowerCase();
    return (categorizedCampaigns[selectedCategory] ?? []).where((event) {
      return event.title.toLowerCase().contains(query) ||
          event.description.toLowerCase().contains(query) ||
          event.organizer.toLowerCase().contains(query) ||
          event.petTypes.any((type) => type.toLowerCase().contains(query));
    }).toList();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title:
          isSearching
              ? TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search events...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              )
              : Text('Pet Community Events'),
      actions: [
        IconButton(
          icon: Icon(isSearching ? Icons.close : Icons.search),
          onPressed: () {
            setState(() {
              if (isSearching) {
                isSearching = false;
                searchQuery = '';
                _searchController.clear();
              } else {
                isSearching = true;
              }
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.filter_list),
          onPressed: () {
            _showFilterDialog(context);
          },
        ),
      ],
    ),
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFD0CFF8), Color(0xFFC4E1FB)],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children:
                    ['Upcoming', 'Seasonal', 'Past'].map((category) {
                      return Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(category),
                          selected: selectedCategory == category,
                          onSelected: (selected) {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                          selectedColor: const Color(0xFF05257C),
                          labelStyle: TextStyle(
                            color:
                                selectedCategory == category
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
          Expanded(
            child:
                filteredCampaigns.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 48, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'No events found',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                    : ListView.builder(
                      padding: EdgeInsets.all(16.0),
                      itemCount: filteredCampaigns.length,
                      itemBuilder: (context, index) {
                        return filteredCampaigns[index];
                      },
                    ),
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        // Add functionality to create a new event
        _showCreateEventDialog(context);
      },
      child: Icon(Icons.add),
      backgroundColor: const Color(0xFF05257C),
    ),
  );
}

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Events'),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CheckboxListTile(
                  title: Text('Dogs'),
                  value: true,
                  onChanged: (bool? value) {},
                ),
                CheckboxListTile(
                  title: Text('Cats'),
                  value: true,
                  onChanged: (bool? value) {},
                ),
                CheckboxListTile(
                  title: Text('Small Pets'),
                  value: true,
                  onChanged: (bool? value) {},
                ),
                CheckboxListTile(
                  title: Text('Wildlife'),
                  value: true,
                  onChanged: (bool? value) {},
                ),
                SwitchListTile(
                  title: Text('Virtual Events Only'),
                  value: false,
                  onChanged: (bool value) {},
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Reset'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text('Apply'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showCreateEventDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create New Event'),
          content: Text(
            'This feature will allow community members to create and submit their own events for approval.',
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text('Coming Soon'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class CampaignEvent extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String date;
  final String location;
  final String contact;
  final String organizer;
  final List<String> petTypes;
  final String requirements;
  final int capacity;
  final int currentParticipants;
  final bool isVirtual;

  CampaignEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
    required this.location,
    required this.contact,
    required this.organizer,
    required this.petTypes,
    required this.requirements,
    required this.capacity,
    required this.currentParticipants,
    required this.isVirtual,
  });

  @override
  Widget build(BuildContext context) {
    final isFull = capacity > 0 && currentParticipants >= capacity;
    final isPast =
        id.startsWith('ev9') || id.startsWith('ev10') || id.startsWith('ev11');

    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => CampaignDetailPage(
                    id: id,
                    title: title,
                    description: description,
                    imageUrl: imageUrl,
                    date: date,
                    location: location,
                    contact: contact,
                    organizer: organizer,
                    petTypes: petTypes,
                    requirements: requirements,
                    capacity: capacity,
                    currentParticipants: currentParticipants,
                    isVirtual: isVirtual,
                  ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.asset(
                    imageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                if (isVirtual)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF05257C),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.videocam, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'Virtual',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (isFull && !isPast)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Full',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: const Color(0xFF05257C)),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(date, style: TextStyle(fontSize: 14)),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: const Color(0xFF05257C)),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children:
                        petTypes.map((type) {
                          return Chip(
                            label: Text(
                              type,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: const Color(0xFF05257C),
                            padding: EdgeInsets.zero,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          );
                        }).toList(),
                  ),
                  if (capacity > 0 && !isPast)
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Capacity: $currentParticipants/$capacity',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          LinearProgressIndicator(
                            value: currentParticipants / capacity,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              currentParticipants >= capacity
                                  ? Colors.red
                                  : const Color(0xFF05257C),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CampaignDetailPage extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String date;
  final String location;
  final String contact;
  final String organizer;
  final List<String> petTypes;
  final String requirements;
  final int capacity;
  final int currentParticipants;
  final bool isVirtual;

  CampaignDetailPage({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
    required this.location,
    required this.contact,
    required this.organizer,
    required this.petTypes,
    required this.requirements,
    required this.capacity,
    required this.currentParticipants,
    required this.isVirtual,
  });

  @override
  _CampaignDetailPageState createState() => _CampaignDetailPageState();
}

class _CampaignDetailPageState extends State<CampaignDetailPage> {
  bool _isRegistered = false;
  bool _isReminded = false;
  bool _isSaved = false;

  @override
  Widget build(BuildContext context) {
    final isPast =
        widget.id.startsWith('ev9') ||
        widget.id.startsWith('ev10') ||
        widget.id.startsWith('ev11');
    final isFull =
        widget.capacity > 0 && widget.currentParticipants >= widget.capacity;
    final canRegister = !isPast && !isFull;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(_isSaved ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () {
              setState(() {
                _isSaved = !_isSaved;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _isSaved ? 'Event saved' : 'Event removed from saved',
                  ),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Share event link copied to clipboard'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
       body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFD0CFF8), Color(0xFFC4E1FB)],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  widget.imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                if (widget.isVirtual)
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF05257C),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.videocam, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'Virtual Event',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (isPast)
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Past Event',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.business, size: 16, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        'Organized by ${widget.organizer}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  if (widget.capacity > 0)
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Registration: ${widget.currentParticipants}/${widget.capacity} spots filled',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: widget.currentParticipants / widget.capacity,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              widget.currentParticipants >= widget.capacity
                                  ? Colors.red
                                  : const Color(0xFF05257C),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            isFull
                                ? 'This event is currently full'
                                : 'Spots are still available',
                            style: TextStyle(
                              color: isFull ? Colors.red : const Color(0xFF05257C),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Divider(height: 32),
                  _buildInfoSection(
                    'Date & Time',
                    Icons.calendar_today,
                    widget.date,
                  ),
                  _buildInfoSection(
                    'Location',
                    Icons.location_on,
                    widget.location,
                  ),
                  _buildInfoSection(
                    'Contact',
                    Icons.contact_phone,
                    widget.contact,
                  ),
                  _buildInfoSection(
                    'Requirements',
                    Icons.assignment,
                    widget.requirements,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'About This Event',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.description,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Pet Types',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        widget.petTypes.map((type) {
                          return Chip(
                            label: Text(
                              type,
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: const Color(0xFF05257C),
                          );
                        }).toList(),
                  ),
                  SizedBox(height: 24),
                  if (!isPast)
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed:
                                canRegister
                                    ? () {
                                      setState(() {
                                        _isRegistered = !_isRegistered;
                                      });
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            _isRegistered
                                                ? 'Successfully registered!'
                                                : 'Registration cancelled',
                                          ),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                    : null,
                            child: Text(
                              _isRegistered
                                  ? 'Cancel Registration'
                                  : 'Register Now',
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _isRegistered ? Colors.red : null,
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _isReminded = !_isReminded;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  _isReminded
                                      ? 'Reminder set for this event'
                                      : 'Reminder removed',
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Icon(
                            _isReminded
                                ? Icons.notifications_active
                                : Icons.notifications_none,
                            color: _isReminded ? const Color(0xFF05257C) : Colors.grey,
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.all(12),
                            shape: CircleBorder(),
                          ),
                        ),
                      ],
                    ),
                  if (isPast)
                    OutlinedButton.icon(
                      onPressed: () {
                        // Show photo gallery or feedback from past event
                        _showPastEventContent(context);
                      },
                      icon: Icon(Icons.photo_library),
                      label: Text('View Event Gallery & Feedback'),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                      ),
                    ),
                  SizedBox(height: 24),
                  Text(
                    'Similar Events',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 220,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildSimilarEventCard(
                          'Wildlife Conservation Workshop',
                          'assets/images/wildlife_workshop.jpg',
                          'May 5, 2025',
                        ),
                        _buildSimilarEventCard(
                          'Stray Animal Feeding Program',
                          'assets/images/stray_feeding.jpg',
                          'April 12, 2025',
                        ),
                        _buildSimilarEventCard(
                          'Pet Adoption Day',
                          'assets/images/adoption_day.jpg',
                          'April 18, 2025',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    )
    );
  }

  Widget _buildInfoSection(String title, IconData icon, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: const Color(0xFF05257C)),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(content, style: TextStyle(fontSize: 16, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarEventCard(String title, String imageUrl, String date) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              imageUrl,
              height: 120,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      date,
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPastEventContent(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Event Gallery & Feedback',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      children: List.generate(
                        9,
                        (index) => ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/gallery${index + 1}.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Participant Feedback',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildFeedbackCard(
                      'Ahmad',
                      4.5,
                      'Great event! Learned a lot about marine conservation.',
                      '2 days ago',
                    ),
                    _buildFeedbackCard(
                      'Sarah',
                      5.0,
                      'The volunteers were very knowledgeable and friendly. Would definitely join again!',
                      '1 week ago',
                    ),
                    _buildFeedbackCard(
                      'Raj',
                      4.0,
                      'Well organized. Would have preferred more hands-on activities.',
                      '2 weeks ago',
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFeedbackCard(
    String name,
    double rating,
    String comment,
    String time,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  ...List.generate(
                    5,
                    (index) => Icon(
                      index < rating.floor()
                          ? Icons.star
                          : (index == rating.floor() && rating % 1 > 0)
                          ? Icons.star_half
                          : Icons.star_border,
                      color: Colors.amber,
                      size: 18,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    rating.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(comment, style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text(time, style: TextStyle(color: Colors.grey, fontSize: 14)),
        ],
      ),
    );
  }
}
