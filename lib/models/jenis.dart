import 'package:cloud_firestore/cloud_firestore.dart';

class Jenis {
  String name;
  String imageUrl;

  Jenis({required this.name, required this.imageUrl});

  factory Jenis.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Jenis(
      imageUrl: data['imageUrl'],
      name: data['name'],
    );
  }
}
