import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helper/shared_preferences.dart';

class CustomerService {
  static const String apiUrl = 'http://10.0.2.2:8000/api/customer';

  // Fetch a single customer by ID
  static Future<Map<String, dynamic>> fetchCustomerById(String id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load customer');
    }
  }

  // Update an existing customer
  static Future<Map<String, dynamic>> updateCustomer(String id, Map<String, dynamic> customerData) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(customerData),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to update customer');
    }
  }
}