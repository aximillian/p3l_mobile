import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helper/shared_preferences.dart';

class PegawaiService {
  static const String apiUrl = 'http://atmabueatyapi.site/api/pegawai';

  // Fetch a single pegawai by ID
  static Future<Map<String, dynamic>> fetchPegawaiById(String id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load pegawai');
    }
  }

  // Fetch the logged-in pegawai's data
  static Future<Map<String, dynamic>> fetchLoggedInPegawai() async {
    final token = await StorageHelper.getToken();
    final response = await http.get(
      Uri.parse('$apiUrl/me'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load pegawai data');
    }
  }

  // Update an existing pegawai
  static Future<Map<String, dynamic>> updatePegawai(String id, Map<String, dynamic> pegawaiData) async {
    final token = await StorageHelper.getToken();
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(pegawaiData),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to update pegawai');
    }
  }
}
