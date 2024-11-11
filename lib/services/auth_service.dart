import 'dart:convert'; // Untuk encoding/decoding JSON
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> login(String username, String password) async {
  const String apiUrl =
      'http://10.0.2.2:8000/api/login'; // URL endpoint API login

  final Map<String, String> loginData = {
    'username': username,
    'password': password,
  };

  final headers = {
    'Content-Type': 'application/json',
  };

  //  POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: headers,
    body: json.encode(loginData),
  );

  
  if (response.statusCode == 200) {

    final responseBody = json.decode(response.body);
    return {
      'status': true,
      'message': responseBody['message'],
      'token': responseBody['access_token'],
      'user': responseBody['user'],
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
