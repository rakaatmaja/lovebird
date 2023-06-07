import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lovebird/pages/food.dart';
import 'package:lovebird/pages/home.dart';
import 'package:lovebird/pages/login/login.dart';
import 'package:lovebird/pages/perawatan.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'l10n/l10n.dart';
import 'pages/jenis.dart';
import 'services/session.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  String? email = await SessionManager.getEmail();
  String? password = await SessionManager.getPassword();
  bool isGoogleLoggedIn = await SessionManager.getGoogleLoginStatus();
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
    email: email,
    password: password,
    isGoogleLoggedIn: isGoogleLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String? email;
  final String? password;
  final bool isGoogleLoggedIn;
  const MyApp({
    required this.isLoggedIn,
    this.email,
    this.password,
    required this.isGoogleLoggedIn,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: L10n.all,
      debugShowCheckedModeBanner: false,
      // initialRoute: isLoggedIn == true ? '/home' : '/',
      initialRoute: isLoggedIn ? '/home' : '/',
      routes: {
        '/': (ctx) => const LoginPage(),
        '/home': (ctx) => const HomePage(),
        '/makanan': (ctx) => const Food(),
        '/jenis': (ctx) => JenisPage(),
        '/perawatan': (ctx) => const PerawatanPage(),
      },
    );
  }
}
