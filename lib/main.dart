import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lovebird/pages/food.dart';
import 'package:lovebird/pages/login/register.dart';
import 'package:lovebird/pages/perawatan.dart';

import 'firebase_options.dart';
import 'l10n/l10n.dart';
import 'pages/home.dart';
import 'pages/jenis.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: L10n.all,
      debugShowCheckedModeBanner: false,
      initialRoute: '/perawatan',
      routes: {
        '/': (ctx) => const RegisterPage(),
        '/makanan': (ctx) => const Food(),
        '/jenis': (ctx) => JenisPage(),
        '/perawatan': (ctx) => const PerawatanPage(),
      },
    );
  }
}
