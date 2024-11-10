import 'package:flutter/material.dart';
import '../helper/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<Map<String, dynamic>> _getUserData() async {
    final userData = await StorageHelper.getUserData();
    if (userData == null) {
      throw Exception('User data not found');
    }
    return userData;
  }

  Future<void> _updateUserData(Map<String, dynamic> userData) async {
    final token = await StorageHelper.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.put(
      Uri.parse('http://10.0.2.2:8000/api/user'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(userData),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user data');
    }

    // Update local storage with new user data
    await StorageHelper.saveUserData(userData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
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
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Username: ${userData['username']}'),
                  Text('Email: ${userData['email']}'),
                  Text('Role: ${userData['role']}'),
                  // Add other user data fields as needed
                  ElevatedButton(
                    onPressed: () async {
                      // Update user data logic here
                      await _updateUserData(userData);
                    },
                    child: const Text('Update Profile'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
