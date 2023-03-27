import 'package:flutter/material.dart';

about(title, subtitle, color) {
  return ListTile(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    iconColor: Colors.black,
    leading: const Icon(Icons.info_sharp),
    title: Text(title),
    subtitle: Text(subtitle),
    tileColor: color,
    trailing:
        const IconButton(onPressed: null, icon: Icon(Icons.arrow_forward_ios)),
  );
}
