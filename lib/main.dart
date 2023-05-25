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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isLoggedIn;
  const MyApp({required this.isLoggedIn, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: L10n.all,
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn == true ? '/home' : '/',
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
