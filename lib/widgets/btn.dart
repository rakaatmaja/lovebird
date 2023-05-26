import 'package:flutter/material.dart';

import '../utils/theme.dart';

textFieldLogin(String title, controller) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      hintText: title,
      focusColor: Colors.grey,
      hoverColor: Colors.grey,
      fillColor: Colors.red,
      hintStyle: kHintText,
    ),
  );
}

 btnGoogle() {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: Colors.grey[400],
      child: SizedBox(
        height: 55,
        child: TextButton(
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
              const Text("Sign up with Google",
                  style: TextStyle(color: Colors.black, fontSize: 16)),
            ],
          ),
          onPressed: () {},
        ),
      ),
    );
  }
