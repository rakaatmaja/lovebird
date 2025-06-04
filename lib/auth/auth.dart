import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lovebird/widgets/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/session.dart';

class Auth {
  Future<void> register(String name, String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'name': name,
        'email': email,
        // Tambahkan data tambahan sesuai kebutuhan Anda
      });

      // Simpan informasi profil pengguna ke SharedPreferences
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('name', user?.displayName ?? '');
      // await prefs.setString('photoUrl', user?.photoURL ?? '');
      // await prefs.setString('email', user?.email ?? '');

      toast('Berhasil daftar!');
    } on FirebaseAuthException catch (e) {
      final result = await (Connectivity().checkConnectivity());
      if (e.code == 'email-already-in-use') {
        toast('Email telah terdaftar');
      }
      // ignore: unrelated_type_equality_checks
      else if (result == ConnectivityResult.none) {
        toast('You are offline');
        // ignore: unrelated_type_equality_checks
      } else {
        toast('Terjadi kesalahan');
      }
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // ignore: unused_local_variable
      User? user = userCredential.user;
      toast('Berhasil masuk!');
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        toast('User tidak ditemukan');
      } else if (e.code == 'wrong-password') {
        toast('Email atau password salah');
      }
      return false;
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> logout() async {
    // Logout dari akun Google jika pengguna login dengan akun Google
    bool isGoogleLoggedIn = await SessionManager.getGoogleLoginStatus();
    if (isGoogleLoggedIn) {
      try {
        await _googleSignIn.signOut();
        await SessionManager.clearGoogleLoginSession();
      } catch (e) {
        // Handle error
      }
    }

    // Hapus sesi login menggunakan email dan password
    bool isEmailPasswordLoggedIn =
        await SessionManager.getEmailPasswordLoginStatus();
    if (isEmailPasswordLoggedIn) {
      await SessionManager.clearEmailPasswordLoginSession();
    }

    // Hapus kunci 'isLoggedIn' dari SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isLoggedIn');
  }

  // Future<void> logout() async {
  //   await FirebaseAuth.instance.signOut();
  // }
}
