import 'package:flutter/material.dart';

Widget itemCategory(image, title, color) {
  return Container(
    height: 100,
    width: 100,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(image),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(title),
        ],
      ),
    ),
  );
}
