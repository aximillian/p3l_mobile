import 'dart:convert'; // Untuk encoding/decoding JSON
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> login(String username, String password) async {
  final String apiUrl =
      'http://10.0.2.2:8000/api/login'; // Ganti dengan URL endpoint API login Anda

  // Membuat request body
  final Map<String, String> loginData = {
    'username': username,
    'password': password,
  };

  // Menentukan header, termasuk Content-Type
  final headers = {
    'Content-Type': 'application/json',
  };

  // Mengirimkan POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: headers,
    body: json.encode(loginData),
  );

  // Menangani respons
  if (response.statusCode == 200) {
    // Jika status code 200, berarti login berhasil
    final responseBody = json.decode(response.body);
    return {
      'status': true,
      'message': responseBody['message'],
      'token': responseBody['access_token'],
      'user': responseBody['user'],
    };
  } else if (response.statusCode == 400 || response.statusCode == 401) {
    // Jika validasi gagal atau kredensial salah
    final responseBody = json.decode(response.body);
    return {
      'status': false,
      'message': responseBody['message'],
    };
  } else {
    // Tangani status code lain
    return {
      'status': false,
      'message': 'Terjadi kesalahan, coba lagi nanti.',
    };
  }
}
