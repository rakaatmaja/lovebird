import 'package:flutter/material.dart';

import '../utils/theme.dart';

textFieldLogin(String title, controller, String? Function(String?)? validator) {
  return TextFormField(
    controller: controller,
    validator: validator,
    decoration: InputDecoration(
      hintText: title,
      focusColor: Colors.grey,
      hoverColor: Colors.grey,
      fillColor: Colors.red,
      hintStyle: kHintText,
    ),
  );
}

String? validateName(value) {
  if (value == null || value.isEmpty) {
    return 'Name must be filled in';
  }
}

String? validateEmail(value) {
  if (value == null || value.isEmpty) {
    return 'Email must be filled in';
  }
  if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
      .hasMatch(value)) {
    return 'Email not valid';
  }
  return null;
}

String? validatePassword(value) {
  if (value == null || value.isEmpty) {
    return 'Password must be filled in';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  return null;
}

btnGoogle(String title) {
  return Card(
    elevation: 1.5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    shadowColor: Colors.grey[400],
    child: SizedBox(
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/crypto%2Fsearch%20(2).png?alt=media&token=24a918f7-3564-4290-b7e4-08ff54b3c94c",
              width: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(title,
                style: const TextStyle(color: Colors.black, fontSize: 16)),
          ],
        ),
        onPressed: () {},
      ),
    ),
  );
}
