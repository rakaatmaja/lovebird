import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lovebird/auth/auth.dart';
import 'package:lovebird/pages/home.dart';
import 'package:lovebird/pages/login/register.dart';
import 'package:lovebird/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/btn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final _auth = Auth();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildBody(),
    );
  }

  buildBody() {
    // final height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome back',
            style: kLogin,
          ),
          const SizedBox(height: 16),
          const Text(
            "Welcome back! Please enter your details.",
            style: kLoginSubtitle,
          ),
          const SizedBox(height: 16),
          textFieldLogin('Email', _emailController),
          const SizedBox(height: 20),
          textFieldLogin('Password', _passwordController),
          const SizedBox(height: 20),
          const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Forgot Password?',
                style: TextStyle(fontWeight: FontWeight.w500),
              )),
          const SizedBox(height: 20),
          btnLogin(),
          const SizedBox(
            height: 16,
          ),
          btnGoogle(),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: RichText(
              text: TextSpan(
                  text: "Don't have an account?  ",
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                        text: 'Sign up here',
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => const RegisterPage()));
                          })
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  btnLogin() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: isLoading ? null : handleLogin,
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
                'Sign in',
                style: kLoginButton,
              ),
      ),
    );
  }

  void handleLogin() async {
    setState(() {
      isLoading = true;
    });

    try {
      bool success = await _auth.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      setState(() {
        isLoading = false;
      });

      if (success) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (ctx) => const HomePage()),
            (route) => false);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }
}
