import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lovebird/auth/auth.dart';
import 'package:lovebird/pages/home.dart';
import 'package:lovebird/pages/login/register.dart';
import 'package:lovebird/services/session.dart';
import 'package:lovebird/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/user.dart';
import '../../widgets/btn.dart';
import '../../widgets/toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late StreamSubscription subscribtion;
  @override
  void initState() {
    super.initState();
    subscribtion =
        Connectivity().onConnectivityChanged.listen((showConnectivityResult) {
      // Got a new connectivity status!
    });
  }

  @override
  void dispose() {
    subscribtion.cancel();
    super.dispose();
  }

  // ignore: unused_element
  void _showConnectivityResult(ConnectivityResult result) {
    // ignore: unrelated_type_equality_checks
    final hasInternet = result != ConnectionState.none;
    final message = hasInternet
        ? result == ConnectivityResult.mobile
            ? toast('You are online with mobile network')
            : toast('You are online with Wifi network')
        : toast('You have no internet');
    _showToast(message);
  }

  void _showToast(message) {
    toast(message);
  }

  final _formKey = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late final GoogleSignInAccount? _googleSignInAccount;
  String? _displayName;
  String? _photoUrl;
  String? _email;

  late SharedPreferences _prefs;

  Future<void> handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        // ignore: unused_local_variable
        final User? user = userCredential.user;
        UserManager.displayName = googleUser.displayName;
        UserManager.email = googleUser.email;
        UserManager.photoUrl = googleUser.photoUrl;

        // if (user != null) {
        // Simpan informasi pengguna di SharedPreferences
        //   _prefs = await SharedPreferences.getInstance();
        //   _prefs.setString('displayName', user.displayName ?? '');
        //   _prefs.setString('photoUrl', user.photoURL ?? '');
        //   _prefs.setString('email', user.email ?? '');
        // Login dengan Google berhasil, lakukan navigasi ke halaman berikutnya
        // ignore: use_build_context_synchronously
        //   Navigator.pushReplacementNamed(context, '/home');
        // }

        // Simpan informasi pengguna di SessionManager
        await SessionManager.setGoogleLoginStatus(true);
        _prefs = await SharedPreferences.getInstance();
        // _prefs.setString('displayName', user.displayName ?? '');
        // _prefs.setString('photoUrl', user.photoURL ?? '');
        // _prefs.setString('email', user.email ?? '');

        // Login dengan Google berhasil, lakukan navigasi ke halaman berikutnya
        toast('Berhasil masuk!');
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      // Handle error
      // ignore: avoid_print
      print(e.toString());
    }
  }

  bool isLoading = false;
  bool isObsecure = true;
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
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                  'Welcome back',
                  style: kLogin,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Welcome back! Please enter your details.",
                  style: kLoginSubtitle,
                ),
                const SizedBox(height: 16),
                textFieldLogin('Email', _emailController, validateEmail,
                    TextInputType.emailAddress, false),
                const SizedBox(height: 20),
                textFieldLogin(
                  'Password',
                  _passwordController,
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
                      isObsecure ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
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
                btnGoogle('Sign in with Google'),
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
                            },
                        )
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

  btnLogin() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: isLoading
            ? null
            : () {
                if (_formKey.currentState!.validate()) {
                  handleLogin();
                }
              },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.black),
          shape: WidgetStateProperty.all(
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

  handleLogin() async {
    final result = await (Connectivity().checkConnectivity());
    // ignore: unrelated_type_equality_checks
    if (result == ConnectivityResult.none) {
      toast('You are offline');
      // ignore: unrelated_type_equality_checks
    } else {
      setState(() {
        isLoading = true;
      });

      try {
        bool isLoggedIn = await _auth.login(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );

        if (isLoggedIn) {
          // Setelah login berhasil, atur status login menggunakan email dan password
          await SessionManager.setEmailPasswordLoginStatus(true,
              _emailController.text.trim(), _passwordController.text.trim());

          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (ctx) => const HomePage()),
          );
        }

        setState(() {
          isLoading = false;
        });

        // if (isLoggedIn) {
        //   SharedPreferences prefs = await SharedPreferences.getInstance();
        //   await prefs.setBool('isLoggedIn', true);

        //   // ignore: use_build_context_synchronously
        //   Navigator.pushAndRemoveUntil(
        //       context,
        //       MaterialPageRoute(builder: (ctx) => const HomePage()),
        //       (route) => false);
        // }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  btnGoogle(String title) {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      // shadowColor: Colors.grey[400],
      child: SizedBox(
        height: 55,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          onPressed: handleGoogleSignIn,
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
        ),
      ),
    );
  }
}
