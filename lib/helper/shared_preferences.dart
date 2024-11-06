import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  // Simpan token di shared preferences
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'access_token', token); 
  }

  // Ambil token dari shared preferences
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs
        .getString('access_token'); 
  }

  // Hapus token dari shared preferences
  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token'); 
  }
}
