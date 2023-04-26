import 'package:flutter/material.dart';

Widget perawatanList(title, color) {
  return Column(
    children: [
      GestureDetector(
        onTap: () => Navigator.push,
        child: ListTile(
          tileColor: Color(color),
          title: Text(title),
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.arrow_forward_ios),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      )
    ],
  );
}
