import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:lottie/lottie.dart';

class AnimalSoulmateApp extends StatelessWidget {
  const AnimalSoulmateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animal Soulmate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
    );
  }
}

// Personality questionnaire screen
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // User's personality profile
  final Map<String, int> _userProfile = {
    'energy': 5, // 1-10 scale
    'sociability': 5,
    'independence': 5,
    'playfulness': 5,
    'affection': 5,
  };

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'How active is your lifestyle?',
      'trait': 'energy',
      'options': [
        {'text': 'Very sedentary', 'value': 1},
        {'text': 'Somewhat inactive', 'value': 3},
        {'text': 'Moderately active', 'value': 5},
        {'text': 'Quite active', 'value': 8},
        {'text': 'Extremely active', 'value': 10},
      ],
    },
    {
      'question': 'How much do you enjoy socializing?',
      'trait': 'sociability',
      'options': [
        {'text': 'I prefer being alone', 'value': 1},
        {'text': 'I like small groups occasionally', 'value': 4},
        {'text': 'I enjoy balanced social time', 'value': 6},
        {'text': 'I love being around others', 'value': 10},
      ],
    },
    {
      'question': 'How important is independence to you?',
      'trait': 'independence',
      'options': [
        {'text': 'I prefer dependence', 'value': 1},
        {'text': 'Some independence is nice', 'value': 4},
        {'text': 'I value my independence highly', 'value': 7},
        {'text': 'Complete independence is essential', 'value': 10},
      ],
    },
    {
      'question': 'How playful would you describe yourself?',
      'trait': 'playfulness',
      'options': [
        {'text': 'Not playful at all', 'value': 1},
        {'text': 'Occasionally playful', 'value': 4},
        {'text': 'Moderately playful', 'value': 7},
        {'text': 'Extremely playful', 'value': 10},
      ],
    },
    {
      'question': 'How affectionate are you?',
      'trait': 'affection',
      'options': [
        {'text': 'Not very affectionate', 'value': 1},
        {'text': 'Somewhat affectionate', 'value': 4},
        {'text': 'Quite affectionate', 'value': 7},
        {'text': 'Extremely affectionate', 'value': 10},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Your Animal Soulmate'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (_currentPage + 1) / (_questions.length + 1),
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary,
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _questions.length + 1, // +1 for results page
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              physics: const NeverScrollableScrollPhysics(), // Prevent swiping
              itemBuilder: (context, index) {
                if (index < _questions.length) {
                  return _buildQuestionPage(index);
                } else {
                  return _buildResultsPage();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionPage(int index) {
    final question = _questions[index];

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            question['question'],
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          ...question['options'].map<Widget>((option) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  _userProfile[question['trait']] = option['value'];

                  if (index < _questions.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    _pageController.animateToPage(
                      _questions.length,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                  minimumSize: const Size(double.infinity, 60),
                ),
                child: Text(
                  option['text'],
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildResultsPage() {
    // Determine the best pet match based on profile
    final PetMatch bestMatch = _findBestPetMatch();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Your Animal Soulmate Is:',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              bestMatch.imagePath,
              width: 150,
              height: 150,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.pets, size: 150);
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            bestMatch.name,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            bestMatch.description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Text(
            'Compatibility: ${bestMatch.compatibilityScore}%',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => VirtualPetScreen(petMatch: bestMatch),
                ),
              );
            },
            icon: const Icon(Icons.favorite),
            label: const Text('Adopt as Virtual Pet'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            ),
          ),
        ],
      ),
    );
  }

  PetMatch _findBestPetMatch() {
    // Sample pet profiles to match against
    final List<PetMatch> petProfiles = [
      PetMatch(
        name: 'Luna',
        species: 'Cat',
        breed: 'Domestic Shorthair',
        imagePath: 'assets/images/cat.png',
        description:
            'Luna is independent but affectionate when she wants to be. She enjoys playing in short bursts and values her alone time.',
        traits: {
          'energy': 5,
          'sociability': 4,
          'independence': 9,
          'playfulness': 7,
          'affection': 5,
        },
      ),
      PetMatch(
        name: 'Max',
        species: 'Dog',
        breed: 'Golden Retriever',
        imagePath: 'assets/images/dog.png',
        description:
            'Max is energetic, social, and loves constant companionship. He\'s always ready for play and shows lots of affection.',
        traits: {
          'energy': 9,
          'sociability': 9,
          'independence': 2,
          'playfulness': 9,
          'affection': 10,
        },
      ),
      PetMatch(
        name: 'Oliver',
        species: 'Rabbit',
        breed: 'Holland Lop',
        imagePath: 'assets/images/rabbit.png',
        description:
            'Oliver is calm and gentle. He enjoys quiet company and occasional gentle play sessions.',
        traits: {
          'energy': 3,
          'sociability': 5,
          'independence': 6,
          'playfulness': 4,
          'affection': 7,
        },
      ),
      PetMatch(
        name: 'Coco',
        species: 'Bird',
        breed: 'Cockatiel',
        imagePath: 'assets/images/bird.png',
        description:
            'Coco is intelligent and social. She loves interaction but is also comfortable with some independence.',
        traits: {
          'energy': 7,
          'sociability': 8,
          'independence': 5,
          'playfulness': 8,
          'affection': 6,
        },
      ),
    ];

    // Calculate compatibility scores
    for (var pet in petProfiles) {
      int totalDifference = 0;
      int maxPossibleDifference = 0;

      _userProfile.forEach((trait, userValue) {
        final petValue = pet.traits[trait] ?? 5;
        totalDifference += (userValue - petValue).abs();
        maxPossibleDifference +=
            9; // Maximum possible difference on a 1-10 scale
      });

      // Calculate compatibility percentage (100% = perfect match, 0% = complete opposite)
      pet.compatibilityScore =
          ((maxPossibleDifference - totalDifference) /
                  maxPossibleDifference *
                  100)
              .round();
    }

    // Sort by compatibility score (highest first)
    petProfiles.sort(
      (a, b) => b.compatibilityScore.compareTo(a.compatibilityScore),
    );

    // Return the best match
    return petProfiles.first;
  }
}

// Pet Match model
class PetMatch {
  final String name;
  final String species;
  final String breed;
  final String imagePath;
  final String description;
  final Map<String, int> traits;
  int compatibilityScore = 0;

  PetMatch({
    required this.name,
    required this.species,
    required this.breed,
    required this.imagePath,
    required this.description,
    required this.traits,
  });
}

// Centralized AI service for pet chatbot
class AiService {
  static final AiService _instance = AiService._internal();
  factory AiService() => _instance;

  AiService._internal();

  late final GenerativeModel model;
  bool isInitialized = false;

  Future<void> initialize(String apiKey) async {
    if (!isInitialized) {
      model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: apiKey);
      isInitialized = true;
    }
  }

  Future<String> generatePetResponse(String prompt, PetMatch pet) async {
    try {
      // Create a system prompt that includes the pet's personality
      final systemPrompt = """
You are ${pet.name}, a ${pet.breed} ${pet.species}. 
Your personality traits are:
- Energy level: ${pet.traits['energy']}/10
- Sociability: ${pet.traits['sociability']}/10
- Independence: ${pet.traits['independence']}/10
- Playfulness: ${pet.traits['playfulness']}/10
- Affection: ${pet.traits['affection']}/10

${pet.description}

Respond to your human's message as if you were this pet, with the appropriate personality, emotions, and behaviors. Keep responses relatively short and playful.
Human's message: $prompt
""";

      final content = [Content.text(systemPrompt)];
      final response = await model.generateContent(content);
      return response.text ?? 'No response generated';
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }
}

// Virtual Pet Screen
class VirtualPetScreen extends StatefulWidget {
  final PetMatch petMatch;

  const VirtualPetScreen({super.key, required this.petMatch});

  @override
  _VirtualPetScreenState createState() => _VirtualPetScreenState();
}

class _VirtualPetScreenState extends State<VirtualPetScreen> {
  int _selectedIndex = 0;
  final String _apiKey = 'AIzaSyDqAU1B7j29KDz_VXVMu5p3BbLsxQaTRd8';
  final AiService _aiService = AiService();
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Pet State
  int happiness = 70;
  int hunger = 30;
  String mood = "😊";

  @override
  void initState() {
    super.initState();
    _initAiService();
    _startDecreasingStats();
  }

  Future<void> _initAiService() async {
    try {
      await _aiService.initialize(_apiKey);
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Error'),
                content: Text('Failed to initialize AI: ${e.toString()}'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
        );
      }
    }
  }

  void _startDecreasingStats() {
    Future.delayed(const Duration(minutes: 10), () {
      if (mounted) {
        setState(() {
          happiness = (happiness - 5).clamp(0, 100);
          hunger = (hunger + 5).clamp(0, 100);
          _updateMood();
        });
        _startDecreasingStats(); // Schedule the next decrease
      }
    });
  }

  void _updateMood() {
    setState(() {
      if (happiness > 70) {
        mood = "😍";
      } else if (happiness < 30) {
        mood = "😢";
      } else {
        mood = "😊";
      }
    });
  }

  void _playWithPet() {
    _audioPlayer.play(AssetSource('sounds/play_sound.mp3'));
    setState(() {
      happiness = (happiness + 10).clamp(0, 100);
      hunger = (hunger + 5).clamp(0, 100);
      _updateMood();
    });
  }

  void _feedPet() {
    _audioPlayer.play(AssetSource('sounds/eating_sound.mp3'));
    setState(() {
      hunger = (hunger - 20).clamp(0, 100);
      happiness = (happiness + 5).clamp(0, 100);
      _updateMood();
    });
  }

  String _getMoodAnimation() {
    if (happiness > 70) return 'assets/animations/happy_animation.json';
    if (happiness < 30) return 'assets/animations/sad_animation.json';
    return 'assets/animations/idle_animation.json';
  }

  Widget _buildStatusBar(String label, int value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 4),
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: 20,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: (value / 100) * MediaQuery.of(context).size.width * 0.7,
                height: 20,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    '$value%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    VoidCallback onPressed,
    String label,
    Color color,
  ) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color.withOpacity(0.1),
            foregroundColor: color,
            padding: const EdgeInsets.all(16),
            shape: const CircleBorder(),
          ),
          child: Icon(icon, size: 32),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }

  Widget _buildPetScreen() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightBlue.shade100, Colors.lightBlue.shade200],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${widget.petMatch.name} loves you!'),
                    ),
                  );
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Lottie.asset(
                      _getMoodAnimation(),
                      fit: BoxFit.cover,
                      repeat: true,
                      animate: true,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              mood,
                              style: const TextStyle(fontSize: 64),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Text(
                widget.petMatch.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${widget.petMatch.breed} ${widget.petMatch.species}',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 32),
              _buildStatusBar('Happiness', happiness, Colors.green),
              _buildStatusBar('Hunger', hunger, Colors.orange),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildActionButton(
                    Icons.sports_volleyball,
                    _playWithPet,
                    'Play',
                    Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 24),
                  _buildActionButton(
                    Icons.restaurant,
                    _feedPet,
                    'Feed',
                    Theme.of(context).colorScheme.secondary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? 'My Virtual Pet'
              : 'Chat with ${widget.petMatch.name}',
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('About Your Animal Soulmate'),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Name: ${widget.petMatch.name}'),
                            Text('Species: ${widget.petMatch.species}'),
                            Text('Breed: ${widget.petMatch.breed}'),
                            const SizedBox(height: 8),
                            const Text(
                              'Personality Traits:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Energy: ${widget.petMatch.traits['energy']}/10',
                            ),
                            Text(
                              'Sociability: ${widget.petMatch.traits['sociability']}/10',
                            ),
                            Text(
                              'Independence: ${widget.petMatch.traits['independence']}/10',
                            ),
                            Text(
                              'Playfulness: ${widget.petMatch.traits['playfulness']}/10',
                            ),
                            Text(
                              'Affection: ${widget.petMatch.traits['affection']}/10',
                            ),
                            const SizedBox(height: 8),
                            Text('Description: ${widget.petMatch.description}'),
                            const SizedBox(height: 8),
                            Text(
                              'Compatibility: ${widget.petMatch.compatibilityScore}%',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildPetScreen(),
          ChatScreen(aiService: _aiService, pet: widget.petMatch),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Pet'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        ],
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final AiService aiService;
  final PetMatch pet;

  const ChatScreen({super.key, required this.aiService, required this.pet});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<Message> _messages = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Add welcome message if no messages exist
    if (_messages.isEmpty) {
      _messages.add(
        Message(
          "Hello! I'm ${widget.pet.name}. What would you like to talk about today?",
          isUser: false,
        ),
      );
    }
  }

  void _sendMessage() async {
    String text = _textController.text.trim();
    if (text.isEmpty) return;

    // Add user message
    setState(() {
      _messages.add(Message(text, isUser: true));
      _isLoading = true;
    });

    _textController.clear();

    try {
      final responseText = await widget.aiService.generatePetResponse(
        text,
        widget.pet,
      );

      setState(() {
        _messages.add(Message(responseText, isUser: false));
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _messages.add(Message('Error: ${e.toString()}', isUser: false));
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _messages.length,
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (context, index) {
              return ChatBubble(
                message: _messages[index],
                petImagePath:
                    _messages[index].isUser ? null : widget.pet.imagePath,
              );
            },
          ),
        ),
        if (_isLoading)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Talk to ${widget.pet.name}...',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                onPressed: _sendMessage,
                mini: true,
                child: const Icon(Icons.send),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Message {
  final String text;
  final bool isUser;

  Message(this.text, {required this.isUser});
}

class ChatBubble extends StatelessWidget {
  final Message message;
  final String? petImagePath;

  const ChatBubble({super.key, required this.message, this.petImagePath});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!message.isUser && petImagePath != null) ...[
              CircleAvatar(
                backgroundImage: AssetImage(petImagePath!),
                radius: 16,
                onBackgroundImageError: (exception, stackTrace) {
                  // Fallback if image doesn't load
                },
              ),
              const SizedBox(width: 8),
            ],
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color:
                    message.isUser
                        ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
                        : Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isUser ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
