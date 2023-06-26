import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lovebird/pages/login/login.dart';
import 'package:lovebird/utils/theme.dart';

import '../../auth/auth.dart';
import '../../services/session.dart';
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
  bool isObsecure = true;
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
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/icon.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
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
                textFieldLogin('Name', nameController, validateName,
                    TextInputType.text, false),
                const SizedBox(height: 16),
                textFieldLogin('Email', emailController, validateEmail,
                    TextInputType.emailAddress, false),
                const SizedBox(height: 16),
                textFieldLogin(
                  'Password',
                  passwordController,
                  validatePassword,
                  TextInputType.text,
                  isObsecure,
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isObsecure = !isObsecure;
                      });
                    },
                    icon: Icon(
                        isObsecure ? Icons.visibility_off : Icons.visibility),
                  ),
                ),
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
        ),
      ),
    );
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
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/google.png',
                height: 30,
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

  btnRegister() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: isLoading
            ? null
            : () {
                if (_formKey.currentState!.validate()) {
                  handleRegister();
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

      await SessionManager.setEmailPasswordLoginStatus(
          true, emailController.text.trim(), passwordController.text.trim());

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
