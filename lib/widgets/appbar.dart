import 'package:flutter/material.dart';

appbar(BuildContext context, title, [action]) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.black),
    backgroundColor: Colors.grey[50],
    elevation: 0,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios)),
    centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(color: Colors.black),
    ),
  );
}
