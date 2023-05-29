import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      Fluttertoast.showToast(
        msg: 'Berhasil daftar',
        fontSize: 16,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Gagal mendaftar',
        fontSize: 16,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
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
      Fluttertoast.showToast(
        msg: 'Berhasil masuk!',
        fontSize: 16,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      return true;
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Email atau password salah!',
        fontSize: 16,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
