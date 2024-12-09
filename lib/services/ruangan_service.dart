import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:p3l_mobile/entity/ruangan.dart';

class RuanganService {
  static const String baseUrl = 'http://atmabueatyapi.site/api'; // Your API base URL
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Fetch all rooms
  Future<List<Ruangan>> fetchRuangans() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/ruangan'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        return (data as List).map((json) => Ruangan.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load rooms');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Update the room status
  Future<void> updateRoomStatus(String roomId, String newStatus) async {
    final token = await _storage.read(key: 'access_token');  // Retrieve token from storage
    if (token == null) {
      throw Exception('No token found.');
    }

    final url = '$baseUrl/ruangan/$roomId'; // API endpoint for updating room status

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Use the token for authorization
        },
        body: json.encode({
          'status': newStatus, // The status you want to update to
        }),
      );

      if (response.statusCode == 200) {
        print('Room status updated successfully');
      } else {
        throw Exception('Failed to update room status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
