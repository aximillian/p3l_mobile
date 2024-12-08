import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helper/shared_preferences.dart';

class CustomerService {
  static const String apiUrl = 'http://atmabueatyapi.site/api/customer';

  // Fetch a single customer by ID
  static Future<Map<String, dynamic>> fetchCustomerById(String id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load customer');
    }
  }

  // Fetch the logged-in customer's data
  static Future<Map<String, dynamic>> fetchLoggedInCustomer() async {
    final token = await StorageHelper.getToken();
    final response = await http.get(
      Uri.parse('$apiUrl/me'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load customer data');
    }
  }

  // Update an existing customer
  static Future<Map<String, dynamic>> updateCustomer(String id, Map<String, dynamic> customerData) async {
    final token = await StorageHelper.getToken();
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(customerData),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to update customer');
    }
  }
}
