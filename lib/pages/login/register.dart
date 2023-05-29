import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lovebird/pages/login/login.dart';
import 'package:lovebird/utils/theme.dart';

import '../../auth/auth.dart';
import '../../widgets/btn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final auth = Auth();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildBody(),
    );
  }

  buildBody() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create an account',
              style: kLogin,
            ),
            const SizedBox(height: 16),
            const Text(
              "Let's get started",
              style: kLoginSubtitle,
            ),
            const SizedBox(height: 30),
            textFieldLogin('Name', nameController, validateName),
            const SizedBox(height: 16),
            textFieldLogin('Email', emailController, validateEmail),
            const SizedBox(height: 16),
            textFieldLogin('Password', passwordController, validatePassword),
            const SizedBox(height: 30),
            btnRegister(),
            const SizedBox(
              height: 16,
            ),
            btnGoogle('Sign up with Google'),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Sign in here',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => const LoginPage(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  btnRegister() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            isLoading ? null : handleRegister;
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
        child: isLoading
            ? const SpinKitFadingCircle(
                size: 50,
                color: Colors.white,
              )
            : const Text(
                'Sign up',
                style: kLoginButton,
              ),
      ),
    );
  }

  Future<void> handleRegister() async {
    setState(() {
      isLoading = true;
    });

    try {
      await auth.register(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      setState(() {
        isLoading = false;
      });

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (ctx) => const LoginPage()),
          (route) => false);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }
}
