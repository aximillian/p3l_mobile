import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:p3l_mobile/entity/riwayat.dart'; 
import 'dart:io';
import '../helper/shared_preferences.dart'; 
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;
  List<Riwayat> transactionHistory = [];  // To store the transaction history
  late String userId;
  late String token;
  bool isLoadingHistory = true;  // Track loading state for transaction history
  late String userRole; // Add userRole to track the role of the user

  // Get the user data from local storage
  Future<Map<String, dynamic>> _getUserData() async {
    final userData = await StorageHelper.getUserData();
    if (userData == null) {
      throw Exception('User data not found');
    }

    // Handle int fields as String (if necessary)
    userData['id_customer'] = userData['id_customer'].toString();
    userData['username'] = userData['username'].toString();
    userData['tanggal_lahir'] = userData['tanggal_lahir'].toString();
    userData['jenis_kelamin'] = userData['jenis_kelamin'].toString();
    userData['alamat_customer'] = userData['alamat_customer'].toString();
    userData['nomor_telepon'] = userData['nomor_telepon'].toString();
    userData['email_customer'] = userData['email_customer'].toString();
    userData['poin_customer'] = userData['poin_customer'].toString();

    return userData;
  }

  // Fetch the transaction history for the given customer ID
  Future<void> _getTransactionHistory(String idCustomer, String token) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/transaksi/$idCustomer'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Log the response status and body for debugging
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List transactions = data['data'] ?? [];
        setState(() {
          transactionHistory = transactions.map((json) => Riwayat.fromJson(json)).toList();
          isLoadingHistory = false;  // Set loading to false after fetching data
        });
      } else {
        throw Exception('Failed to load transaction history');
      }
    } catch (e) {
      // Log the error message
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      setState(() {
        isLoadingHistory = false;  // Stop loading even if there's an error
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Fetch user data and token once when the widget is created
    _getUserData().then((userData) {
      userId = userData['id_customer'];
      
      // Fetch token and transaction history
      StorageHelper.getToken().then((token) {
        if (token != null) {
          _getTransactionHistory(userId, token);  // Only fetch transaction history once
        }
      });

      // Fetch user role
      StorageHelper.getUserRole().then((role) {
        setState(() {
          userRole = role ?? 'customer'; // Default to 'customer' if role is not found
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading profile data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No profile data available'));
          } else {
            final userData = snapshot.data!;

            return FutureBuilder<String?>(
              future: StorageHelper.getToken(),
              builder: (context, tokenSnapshot) {
                if (tokenSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (tokenSnapshot.hasError) {
                  return const Center(child: Text('Error loading token'));
                } else if (!tokenSnapshot.hasData || tokenSnapshot.data == null) {
                  return const Center(child: Text('No token available'));
                } else {
                  token = tokenSnapshot.data!;  // Store the token after it is fetched
                  userId = userData['id_customer'];

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Profile picture with the option to change
                        GestureDetector(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(80.0),
                            child: _profileImage == null
                                ? Image.network(
                                    userData['profile_customer'] ?? '',
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    _profileImage!,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Tap on the profile picture to change',
                          style: GoogleFonts.lato(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 20),

                        // Display user profile data based on role
                        if (userRole == 'customer') ...[
                          _buildProfileCard('Username', userData['username'] ?? ''),
                          _buildProfileCard(
                            'Tanggal Lahir',
                            userData['tanggal_lahir'] is String
                                ? userData['tanggal_lahir']
                                : DateFormat('dd-MM-yyyy').format(
                                    DateTime.parse(userData['tanggal_lahir']?.toString() ?? '')),
                          ),
                          _buildProfileCard('Jenis Kelamin', userData['jenis_kelamin'] ?? ''),
                          _buildProfileCard('Alamat', userData['alamat_customer'] ?? ''),
                          _buildProfileCard('Nomor Telepon', userData['nomor_telepon'] ?? ''),
                          _buildProfileCard('Email', userData['email_customer'] ?? ''),
                          _buildProfileCard('Poin Customer', userData['poin_customer']?.toString() ?? '0'),

                          // Transaction History Section
                          const SizedBox(height: 20),
                          Text(
                            'Riwayat Transaksi',
                            style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          isLoadingHistory
                              ? const Center(child: CircularProgressIndicator())  // Show a loading spinner while fetching
                              : transactionHistory.isEmpty
                                  ? const Center(child: Text('No transaction history available.'))
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: transactionHistory.length,
                                      itemBuilder: (context, index) {
                                        final transaction = transactionHistory[index];
                                        return _buildTransactionCard(transaction);
                                      },
                                    ),
                        ] else if (userRole == 'pegawai') ...[
                          _buildProfileCard('Nama', userData['username'] ?? ''),
                          _buildProfileCard('Jabatan', userData['jabatan'] ?? ''),
                          _buildProfileCard('Nomor Telepon', userData['nomor_telepon'] ?? ''),
                        ],
                      ],
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  // Method to build a transaction card
  Widget _buildTransactionCard(Riwayat transaction) {
    final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    String formattedNominal = NumberFormat.currency(symbol: 'IDR ', decimalDigits: 2).format(transaction.nominalTransaksi);
    String formattedDate = dateFormat.format(DateTime.parse(transaction.tanggalTransaksi));

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: const Icon(Icons.receipt, color: Colors.blueAccent),
        title: Text('Nomor Transaksi: ${transaction.idCustomer}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tanggal: $formattedDate'),
            Text('Jenis Transaksi: ${transaction.jenisTransaksi}'),
            Text('Status: ${transaction.statusTransaksi}'),
            Text('Keluhan: ${transaction.keluhan ?? 'N/A'}'),
          ],
        ),
        trailing: Text(formattedNominal),
      ),
    );
  }

  // Widget to create a profile data card with adjusted padding for a more compact grid
  Widget _buildProfileCard(String title, String value) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12.0),
        title: Text(
          title,
          style: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        subtitle: Text(
          value,
          style: GoogleFonts.lato(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
