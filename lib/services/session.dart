import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String isLoggedInKey = 'isLoggedIn';
  static const String emailKey = 'email';
  static const String passwordKey = 'password';
  static const String displayNameKey = 'name';
  // static const String photoUrlKey = 'photoUrl';

  // ...

  // Mengatur informasi profil pengguna
  static Future<void> setUserInfo(
      String name, String email, String photoUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(displayNameKey, name);
    await prefs.setString(emailKey, email);
    // await prefs.setString(photoUrlKey, photoUrl);
  }

  // Mendapatkan nama pengguna
  static Future<String?> getDisplayName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(displayNameKey);
  }

  // Mendapatkan URL foto profil
  // static Future<String?> getPhotoUrl() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(photoUrlKey);
  // }

  // Mengatur status login menggunakan email dan password
  static Future<void> setEmailPasswordLoginStatus(
      bool isLoggedIn, String email, String password) async {
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
    await prefs.remove('displayName');
    await prefs.remove('photoUrl');
    await prefs.remove('email');
  }
}
