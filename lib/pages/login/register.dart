import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  buildBody() {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 100,
              color: Colors.red,
            )
          ],
        ),
      ],
    );
  }
}
