import 'package:cloud_firestore/cloud_firestore.dart';

class Pet {
  final String id;
  final String name;
  final String age;
  final String breed;
  final String colour;
  final String description;
  final String email;
  final String location;
  final String ownedBy;
  final String petType;
  final String phoneNumber;
  final String adoptionFee;
  final String imagePath;
  final String sex;
  final String weight;


  Pet({
    required this.id,
    required this.name,
    required this.age,
    required this.breed,
    required this.colour,
    required this.description,
    required this.email,
    required this.location,
    required this.ownedBy,
    required this.petType,
    required this.phoneNumber,
    required this.adoptionFee,
    required this.imagePath,
    required this.sex,
    required this.weight,
  });

  // Convert Firestore snapshot into Pet object
  factory Pet.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Pet(
      id: snapshot.id,
      name: data['name'] ?? '',
      age: data['age'] ?? '',
      location: data['location'] ?? '',
      breed: data['breed'] ?? '',
      sex: data['sex'] ?? '',
      colour: data['colour'] ?? '',
      description: data['description'] ?? '',
      email: data['email'] ?? '',
      ownedBy: data['ownedBy'] ?? '',
      petType: data['petType'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      adoptionFee: data['adoptionFee'] ?? '',
      imagePath: data['imagePath'] ?? '', // Now stores Firestore URL
      weight: data['weight'] ?? '',
    );
  }


}
