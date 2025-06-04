import 'package:cloud_firestore/cloud_firestore.dart';

class PhotoItem {
  String name;
  String url;

  PhotoItem({
    required this.name,
    required this.url,
  });

  factory PhotoItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return PhotoItem(
      name: data['name'].toString(),
      url: data['url'].toString(),
    );
  }
}
