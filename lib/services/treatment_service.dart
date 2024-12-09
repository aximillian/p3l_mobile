import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p3l_mobile/entity/treatment.dart';

class TreatmentService {
  static const String baseUrl = 'http://atmabueatyapi.site/api';

  Future<List<Treatment>> fetchTreatments() async {
    final response = await http.get(Uri.parse('$baseUrl/perawatan'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return (data as List).map((json) => Treatment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load treatments');
    }
  }

  Future<Treatment> fetchTreatmentById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/perawatan/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return Treatment.fromJson(data);
    } else {
      throw Exception('Treatment not found');
    }
  }

  Future<List<Treatment>> searchTreatmentsByName(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/perawatan/search/$name'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return (data as List).map((json) => Treatment.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}
