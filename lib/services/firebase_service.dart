import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pet_model.dart';

class FirebaseService {
  final CollectionReference petCollection = FirebaseFirestore.instance.collection('pets');

  Stream<List<Pet>> getPets() {
    return petCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Pet.fromSnapshot(doc)).toList());
  }
}
