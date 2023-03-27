import 'package:flutter/material.dart';

Widget itemCategory(image, title, color) {
  return Column(
    children: [
      Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Image.asset(image),
            const SizedBox(
              height: 5,
            ),
            Text(title),
          ],
        ),
      ),
    ],
  );
}
