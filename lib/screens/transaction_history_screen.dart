import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:p3l_mobile/entity/riwayat.dart';
import 'package:p3l_mobile/theme/app_theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TransactionHistoryScreen extends StatefulWidget {
  final String userId;
  final String token;

  const TransactionHistoryScreen({super.key, required this.userId, required this.token});

  @override
  _TransactionHistoryScreenState createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  List<Riwayat> transactionHistory = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getTransactionHistory();
  }

  Future<void> _getTransactionHistory() async {
    try {
      final response = await http.get(
        Uri.parse('http://atmabueatyapi.site/api/transaksi/showRiwayatCustomer/${widget.userId}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.token}',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List transactions = data['data'] ?? [];
        setState(() {
          transactionHistory = transactions.map((json) => Riwayat.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load transaction history');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transaction History',
          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppTheme.pinkColor,
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.5),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.pinkColor, AppTheme.whiteColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : transactionHistory.isEmpty
                ? const Center(child: Text('No transaction history available.'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: transactionHistory.length,
                    itemBuilder: (context, index) {
                      final transaction = transactionHistory[index];
                      return _buildTransactionCard(transaction);
                    },
                  ),
      ),
    );
  }

  Widget _buildTransactionCard(Riwayat transaction) {
    final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    String formattedNominal = NumberFormat.currency(symbol: 'IDR ', decimalDigits: 2).format(transaction.nominalTransaksi);
    String formattedDate = dateFormat.format(DateTime.parse(transaction.tanggalTransaksi));

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12.0),
        leading: const Icon(Icons.receipt, color: AppTheme.blackColor),
        title: Text('Nomor Transaksi: ${transaction.idCustomer}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tanggal: $formattedDate'),
            Text('Jenis Transaksi: ${transaction.jenisTransaksi}'),
            Text('Status: ${transaction.statusTransaksi}'),
            Text('Keluhan: ${transaction.keluhan.isNotEmpty ? transaction.keluhan : 'N/A'}'),
          ],
        ),
        trailing: Text(formattedNominal),
      ),
    );
  }
}