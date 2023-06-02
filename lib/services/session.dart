import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static final String isLoggedInKey = 'isLoggedIn';
  static final String emailKey = 'email';
  static final String passwordKey = 'password';

  // Mengatur status login menggunakan email dan password
  static Future<void> setEmailPasswordLoginStatus(bool isLoggedIn, String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoggedInKey, isLoggedIn);
    await prefs.setString(emailKey, email);
    await prefs.setString(passwordKey, password);
  }

  // Mendapatkan status login menggunakan email dan password
  static Future<bool> getEmailPasswordLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey) ?? false;
  }

  // Mendapatkan email yang digunakan untuk login menggunakan email dan password
  static Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(emailKey);
  }

  // Mendapatkan password yang digunakan untuk login menggunakan email dan password
  static Future<String?> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(passwordKey);
  }

  // Menghapus sesi login menggunakan email dan password
  static Future<void> clearEmailPasswordLoginSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(isLoggedInKey);
    await prefs.remove(emailKey);
    await prefs.remove(passwordKey);
  }

  // Mengatur status login menggunakan Google
  static Future<void> setGoogleLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoggedInKey, isLoggedIn);
  }

  // Mendapatkan status login menggunakan Google
  static Future<bool> getGoogleLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey) ?? false;
  }

  // Hapus sesi login menggunakan Google
  static Future<void> clearGoogleLoginSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(isLoggedInKey);
  }
}
