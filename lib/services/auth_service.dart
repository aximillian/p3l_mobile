import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helper/shared_preferences.dart';

Future<Map<String, dynamic>> login(String username, String password) async {
  const String apiUrl = 'http://atmabueatyapi.site/api/mobile/loginMo'; // URL endpoint API login

  final Map<String, String> loginData = {
    'username': username,
    'password': password,
  };

  final headers = {
    'Content-Type': 'application/json',
  };

  // POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: headers,
    body: json.encode(loginData),
  );

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);
    if (responseBody['user']['jabatan_pegawai'] != null) {
      final jabatanPegawai = responseBody['user']['jabatan_pegawai'];
      if (jabatanPegawai != 'Kepala Klinik' && jabatanPegawai != 'Beautician') {
        return {
          'status': false,
          'message': 'Pegawai tidak memiliki akses login.',
        };
      }
      await StorageHelper.saveUserRole('pegawai');
    } else {
      await StorageHelper.saveUserRole('customer');
    }

    await StorageHelper.saveToken(responseBody['access_token']);
    await StorageHelper.saveUserData(responseBody['user']);

    return {
      'status': true,
      'message': responseBody['message'],
      'token': responseBody['access_token'],
      'user': responseBody['user'],
      'role': responseBody['role'],
    };
  } else if (response.statusCode == 400 || response.statusCode == 401) {
    final responseBody = json.decode(response.body);
    return {
      'status': false,
      'message': responseBody['message'],
    };
  } else {
    return {
      'status': false,
      'message': 'Terjadi kesalahan, coba lagi nanti.',
};
  }
}