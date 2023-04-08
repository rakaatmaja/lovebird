// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// final _firestore = FirebaseFirestore.instance;

// StreamBuilder<QuerySnapshot>(
//   stream: _firestore.collection("nama_collection").snapshots(),
//   builder: (context, snapshot) {
//     if (!snapshot.hasData) {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//     final List<DocumentSnapshot> data = snapshot.data!.docs;
//     return ListView.builder(
//       itemCount: data.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(data[index].data()["nama_field"]),
//         );
//       },
//     );
//   },
// );
