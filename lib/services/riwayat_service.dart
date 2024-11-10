import 'package:http/http.dart' as http;
import 'package:p3l_mobile/entity/riwayat.dart';
import 'dart:convert';

class TransactionService {
  // Define the base URL of the API
  static const String baseUrl = 'http://127.0.0.1:8000/api'; // Make sure this is correct

  // Method to fetch the transaction history by customer ID
  Future<List<Riwayat>> fetchTransactionHistory(String idCustomer, String token) async {
    // Debugging: print the URL and token
    print('Fetching transaction history from: $baseUrl/transaksi/$idCustomer');
    print('Authorization header: Bearer $token');
    
    final response = await http.get(
      Uri.parse('$baseUrl/transaksi/$idCustomer'),  // Correct base URL
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Parse the JSON response
      final data = json.decode(response.body);
      final List transactions = data['data'] ?? [];

      // Convert each transaction JSON into a Riwayat model
      return transactions.map((json) {
        // Ensure the proper type conversion here
        return Riwayat.fromJson({
          'id_customer': json['id_customer']?.toString() ?? '',
          'id_pegawai': json['id_pegawai']?.toString() ?? '',
          'id_dokter': json['id_dokter']?.toString() ?? '',
          'id_kasir': json['id_kasir']?.toString() ?? '',
          'id_beautician': json['id_beautician']?.toString() ?? '',
          'id_promo': json['id_promo']?.toString() ?? '',
          'tanggal_transaksi': json['tanggal_transaksi']?.toString() ?? '',
          'jenis_transaksi': json['jenis_transaksi']?.toString() ?? '',
          'status_transaksi': json['status_transaksi']?.toString() ?? '',
          'nominal_transaksi': json['nominal_transaksi'] is int
              ? (json['nominal_transaksi'] as int).toDouble()
              : json['nominal_transaksi'] is double
                  ? json['nominal_transaksi']
                  : 0.0,  // Ensure this is a double
          'keluhan': json['keluhan']?.toString() ?? '',
        });
      }).toList();
    } else {
      throw Exception('Failed to load transaction history');
    }
  }
}
