import 'package:cloud_firestore/cloud_firestore.dart';

class PhotoItem {
  String name;
  String url;

  PhotoItem({
    required this.name,
    required this.url,
  });

  // factory PhotoItem.fromJson(Map<String, dynamic> json) {
  //   return PhotoItem(
  //     name: json['name'],
  //     url: json['url'],
  //   );
  // }

  factory PhotoItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PhotoItem(
      name: data['name'],
      url: data['url'],
    );
  }
}
