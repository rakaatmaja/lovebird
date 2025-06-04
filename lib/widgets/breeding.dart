import 'package:flutter/material.dart';

import '../utils/theme.dart';

Widget perawatanList([title, image, desc, color]) {
  return Card(
    elevation: 0,
    child: Container(
      decoration: BoxDecoration(
        color: Color(color),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: kTitleFood,
            ),
            const SizedBox(
              height: 5,
            ),
            Image.network(
              image,
              height: 200,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              desc,
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
    ),
  );
}
