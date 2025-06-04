import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lovebird/pages/food.dart';
import 'package:lovebird/pages/jenis.dart';
import 'package:lovebird/pages/perawatan.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/login/login.dart';

class CustomDrawer extends StatelessWidget {
  final String? displayName;
  final String? email;
  final String? photoUrl;

  CustomDrawer({
    Key? key,
    this.displayName,
    this.email,
    this.photoUrl,
  }) : super(key: key);
  final List<Map<String, String>> drawerItems = [
    // {'image': 'assets/icons/food.png', 'text': 'Bahasa'},
    {'image': 'assets/icons/food.png', 'text': 'Makanan'},
    {'image': 'assets/icons/footprint.png', 'text': 'Jenis'},
    {'image': 'assets/icons/care.png', 'text': 'Perawatan'},
    {'image': 'assets/icons/gender.png', 'text': 'Gender'},
    {'image': 'assets/icons/info.png', 'text': 'Info'},
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(displayName ?? ''),
            accountEmail: Text(email ?? ''),
            currentAccountPicture: CircleAvatar(
              backgroundImage:
                  photoUrl != null ? NetworkImage(photoUrl!) : null,
            ),
          ),
          ...drawerItems.map((item) {
            return ListTile(
              leading: Image.asset(item['image']!),
              title: Text(item['text']!),
              onTap: () {
                navigateToPage(context, item['text']!);
              },
            );
          }).toList(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              logoutWithGoogle(context);
            },
          ),
        ],
      ),
    );
  }

  void navigateToPage(BuildContext context, String pageTitle) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => getPageByTitle(pageTitle)),
    );
  }

  Widget getPageByTitle(String pageTitle) {
    // Tambahkan logika untuk mengembalikan halaman yang sesuai berdasarkan `pageTitle`
    // Misalnya, menggunakan switch case untuk memetakan judul ke halaman yang sesuai
    switch (pageTitle) {
      // case 'Bahasa':
      //   return LanguagePage();
      case 'Makanan':
        return const Food();
      case 'Jenis':
        return JenisPage();
      case 'Perawatan':
        return const PerawatanPage();
      // case 'Gender':
      //   return Gender();
      // case 'Info':
      //   return Info();
      default:
        return Container(); // Halaman default jika judul tidak cocok
    }
  }

  Future<void> logoutWithGoogle(BuildContext context) async {
    try {
      // Lakukan logout untuk metode login Google
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      // Logout juga dari Firebase Authentication
      await FirebaseAuth.instance.signOut();

      // Hapus status login dari SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);

      // Setelah logout berhasil, kembali ke halaman login atau halaman awal aplikasi
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    } catch (e) {
      print('Error during Google logout: $e');
      // Tampilkan pesan error atau aksi lain sesuai kebutuhan aplikasi
    }
  }
}
