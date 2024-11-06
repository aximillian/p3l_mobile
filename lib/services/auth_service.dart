import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Ganti import
import 'package:p3l_mobile/entity/user.dart';

class AuthService {
  // Base URL untuk API
  static const String baseUrl =
      'http://10.0.2.2:8000/mobile'; // Pastikan menggunakan base URL yang sesuai

  // Fungsi login
  Future<User?> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/login'); // Endpoint login API Laravel

    try {
      // Menambahkan print untuk melihat request yang dikirim
      print('Mengirimkan request ke: $url');
      print('Data yang dikirim: {"username": "$username", "password": "$password"}');

      // Mengirimkan request POST ke server dengan username dan password
      final response = await http.post(
        url,
        body: json.encode({
          'username': username,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json', // Mengirimkan data dalam format JSON
        },
      ).timeout(Duration(seconds: 30)); // Timeout 30 detik

      // Menambahkan print untuk status code dan body response
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      // Jika status code 200, artinya login berhasil
      if (response.statusCode == 200) {
        final data = json.decode(response.body); // Mendekode response body
        final user = User.fromJson(data['user']); // Parsing user data
        await saveToken(data['access_token']); // Menyimpan token ke SharedPreferences
        return user; // Kembalikan objek user yang berhasil login
      } else {
        // Jika login gagal (status code selain 200)
        print('Login failed with status code: ${response.statusCode}');
        print('Error: ${response.body}');
        return null;
      }
    } catch (e) {
      // Jika ada error saat menghubungi server
      print('Login error: $e');
      return null;
    }
  }

  // Fungsi untuk menyimpan token ke SharedPreferences
  Future<void> saveToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'access_token', token); // Menyimpan token dengan key 'access_token'
    } catch (e) {
      print('Error saving token: $e');
    }
  }

  // Fungsi untuk mengambil token dari SharedPreferences
  Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('access_token'); // Mengambil token dari shared preferences
    } catch (e) {
      print('Error retrieving token: $e');
      return null;
    }
  }

  // Fungsi untuk logout (menghapus token)
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('access_token'); // Menghapus token dari shared preferences
    } catch (e) {
      print('Error logging out: $e');
    }
  }
}
