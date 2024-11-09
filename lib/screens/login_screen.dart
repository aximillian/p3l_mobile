import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Untuk menampilkan pesan toast
import 'package:p3l_mobile/theme/app_theme.dart';
import '../services/auth_service.dart'; // Impor fungsi login yang telah dibuat
import '../widgets/custom_textfield.dart'; // Impor custom textfield
import '../widgets/custom_button.dart'; // Impor custom button
import '../widgets/custom_loading_spinner.dart'; // Impor custom loading spinner

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    final response = await login(
      _usernameController.text,
      _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (response['status']) {
      Fluttertoast.showToast(msg: response['message']);
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Fluttertoast.showToast(msg: response['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login.jpeg'),
            fit: BoxFit.contain,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.blackColor.withOpacity(
                0.5), // Efek transparansi untuk kontras
          ),
          child: Column(
            // Vertical
            mainAxisAlignment: MainAxisAlignment.end,

            // Horizontal
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              const Text(
                'Your Journey to\nTimeless Beauty\nBegins Here',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.whiteColor,
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: AppTheme.pinkColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    // Username
                    CustomTextField(
                      controller: _usernameController,
                      labelText: 'Username',
                    ),
                    const SizedBox(height: 20),

                    //Password
                    CustomTextField(
                      controller: _passwordController,
                      labelText: 'Password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 30),

                    // Button Login
                    _isLoading
                        ? const CustomLoadingSpinner()
                        : CustomButton(
                            text: 'Login',
                            onPressed: _login,
                          ),
                      const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
