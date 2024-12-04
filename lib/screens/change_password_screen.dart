import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p3l_mobile/theme/app_theme.dart';
import 'package:p3l_mobile/services/customer_service.dart';
import 'package:p3l_mobile/services/pegawai_service.dart';

class ChangePasswordScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  final String userRole;

  const ChangePasswordScreen({super.key, required this.userData, required this.userRole});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {
      final newPassword = _newPasswordController.text;
      // final userId = widget.userData['id_customer'] ?? widget.userData['id'];
      final userId = widget.userRole == 'pegawai'
          ? widget.userData['id_pegawai'].toString()
          : (widget.userData['id_customer'] ?? widget.userData['id'])
              .toString();
      try {
        if (widget.userRole == 'customer') {
          await CustomerService.updateCustomer(userId, {...widget.userData, 'password': newPassword});
        } else if (widget.userRole == 'pegawai') {
          await PegawaiService.updatePegawai(userId, {...widget.userData, 'password': newPassword});
        }
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password changed successfully')));
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppTheme.pinkColor,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.pinkColor, AppTheme.whiteColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Change Your Password',
                  style: GoogleFonts.lato(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.blackColor,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _currentPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Current Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your current password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _newPasswordController,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your new password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm New Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your new password';
                    }
                    if (value != _newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _changePassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.pinkColor,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: GoogleFonts.lato(fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text('Change Password'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}