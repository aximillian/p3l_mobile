import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p3l_mobile/theme/app_theme.dart';

class AccountDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  const AccountDetailsScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Details',
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailCard('Username', userData['username']),
              _buildDetailCard('Date of Birth', userData['tanggal_lahir']),
              _buildDetailCard('Gender', userData['jenis_kelamin']),
              _buildDetailCard('Address', userData['alamat_customer']),
              _buildDetailCard('Phone Number', userData['nomor_telepon']),
              _buildDetailCard('Email', userData['email_customer']),
              _buildDetailCard('Allergy', userData['alergi_obat']),
              _buildDetailCard('Points', userData['poin_customer'].toString()),
              _buildDetailCard('Registration Date', userData['tanggal_registrasi']),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard(String title, String value) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12.0),
        title: Text(
          title,
          style: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.blackColor,
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