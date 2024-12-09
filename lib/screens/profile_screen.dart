import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:p3l_mobile/entity/riwayat.dart';
import 'package:p3l_mobile/screens/account_details_screen.dart';
import 'package:p3l_mobile/screens/change_password_screen.dart';
import 'package:p3l_mobile/screens/transaction_history_screen.dart';
import 'package:p3l_mobile/screens/update_room_screen.dart';
import 'package:p3l_mobile/theme/app_theme.dart';
import 'package:p3l_mobile/widgets/profile_card.dart';
import 'dart:io';
import '../helper/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;
  List<Riwayat> transactionHistory = [];
  late String userId;
  late String token;
  bool isLoadingHistory = true;
  late String userRole;

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  Future<void> _initializeUserData() async {
    final userData = await _getUserData();
    userId = userData['id_customer'];
    final token = await StorageHelper.getToken();
    if (token != null) {
      _getTransactionHistory(userId, token);
    }
    final role = await StorageHelper.getUserRole();
    setState(() {
      userRole = role ?? 'customer';
    });
  }

  Future<Map<String, dynamic>> _getUserData() async {
    final userData = await StorageHelper.getUserData();
    if (userData == null) {
      throw Exception('User data not found');
    }
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

  Future<void> _getTransactionHistory(String idCustomer, String token) async {
    try {
      final response = await http.get(
        Uri.parse('http://atmabueatyapi.site/api/transaksi/$idCustomer'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List transactions = data['data'] ?? [];
        setState(() {
          transactionHistory = transactions.map((json) => Riwayat.fromJson(json)).toList();
          isLoadingHistory = false;
        });
      } else {
        setState(() {
          isLoadingHistory = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      setState(() {
        isLoadingHistory = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppTheme.pinkColor,
        elevation: 10, // Add elevation for shadow effect
        shadowColor: Colors.black.withOpacity(0.5), // Shadow color
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.pinkColor, AppTheme.whiteColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<Map<String, dynamic>>(
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
              return _buildProfileContent(userData);
            }
          },
        ),
      ),
    );
  }

  Widget _buildProfileContent(Map<String, dynamic> userData) {
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
          token = tokenSnapshot.data!;
          userId = userData['id_customer'];
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (userRole == 'customer') ...[
                  _buildCustomerProfile(userData),
                ] else if (userRole == 'pegawai') ...[
                  _buildEmployeeProfile(userData),
                ],
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildCustomerProfile(Map<String, dynamic> userData) {
    return Column(
      children: [
        _buildProfileHeader(userData),
        ProfileCard(
          title: 'My Point',
          value: '${userData['poin_customer']?.toString() ?? '0'} pt',
          leading: const Icon(Icons.monetization_on, color: AppTheme.blackColor),
          titleStyle: GoogleFonts.lato(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: AppTheme.blackColor,
          ),
          valueStyle: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.blackColor,
          ),
        ),
        const SizedBox(height: 20),
        ProfileCard(
          title: 'Account',
          value: '',
          leading: const Icon(Icons.account_circle, color: AppTheme.blackColor),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AccountDetailsScreen(userData: userData)));
          },
        ),
        ProfileCard(
          title: 'Change Password',
          value: '',
          leading: const Icon(Icons.lock, color: AppTheme.blackColor),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChangePasswordScreen(userData: userData, userRole: userRole),
            ));
          },
        ),
        ProfileCard(
          title: 'History Transaksi',
          value: '',
          leading: const Icon(Icons.history, color: AppTheme.blackColor),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => TransactionHistoryScreen(userId: userId, token: token)));
          },
        ),
        const SizedBox(height: 20),
        ProfileCard(
          title: 'Sign Out',
          value: '',
          leading: const Icon(Icons.logout, color: Colors.red),
          titleStyle: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
          onTap: _showLogoutConfirmation,
        ),
      ],
    );
  }

  Widget _buildEmployeeProfile(Map<String, dynamic> userData) {
    return Column(
      children: [
        Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12.0),
            title: Text(
              userData['nama_pegawai'] ?? '',
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.blackColor,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Position: ${userData['jabatan_pegawai'] ?? ''}',
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Phone: ${userData['nomor_telepon'] ?? ''}',
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (userRole == 'pegawai' && userData['jabatan_pegawai'] == 'Beautician') ...[
          ProfileCard(
            title: 'Update Room',
            value: '',
            leading: const Icon(Icons.room, color: AppTheme.blackColor),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UpdateRoomScreen()));
            },
          ),
        ],
        ProfileCard(
          title: 'Change Password',
          value: '',
          leading: const Icon(Icons.lock, color: AppTheme.blackColor),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChangePasswordScreen(userData: userData, userRole: userRole),
            ));
          },
        ),
        ProfileCard(
          title: 'Sign Out',
          value: '',
          leading: const Icon(Icons.logout, color: Colors.red),
          titleStyle: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
          onTap: _showLogoutConfirmation,
        ),
      ],
    );
  }

  Widget _buildProfileHeader(Map<String, dynamic> userData) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12.0),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(40.0),
          child: Image.asset(
            'assets/images/avatar.jpg',
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          userData['nama_customer'] ?? '',
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.blackColor,
          ),
        ),
        subtitle: Text(
          userData['email_customer'] ?? '',
          style: GoogleFonts.lato(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                _logout();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout() async {
    await StorageHelper.removeToken();
    await StorageHelper.removeUserData();
    await StorageHelper.removeUserRole();
    Navigator.of(context).pushReplacementNamed('/home');
  }
}
