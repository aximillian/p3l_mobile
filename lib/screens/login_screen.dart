import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:p3l_mobile/theme/app_theme.dart';
import '../services/auth_service.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_loading_spinner.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _rememberMe = false;
  bool _acceptTerms = false;

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

      // Background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.pinkColor, AppTheme.whiteColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        // Content
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(

            // Login Form
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),

              // content dalam form
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // Welcome Text
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.pinkColor,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black45,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  // Sign in Text
                  const Text(
                    'Sign in with your account',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.blackColor,
                    ),
                  ),
                  const SizedBox(height: 35),

                  // Username Field
                  CustomTextField(
                    controller: _usernameController,
                    labelText: 'Username',
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  CustomTextField(
                    controller: _passwordController,
                    labelText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),

                  // Forgot Password Option
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        // Add forgot password functionality
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: AppTheme.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Checkbox Remember Me
                  Row(
                    children: [
                      Checkbox(
                        activeColor: AppTheme.blackColor,
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                      ),
                      const Text('Remember Me'),
                    ],
                  ),

                  // Checkbox Accept Terms
                  Row(
                    children: [
                      Checkbox(
                        activeColor: AppTheme.blackColor,
                        value: _acceptTerms,
                        onChanged: (value) {
                          setState(() {
                            _acceptTerms = value!;
                          });
                        },
                      ),
                      const Flexible(
                        child: Text('I accept the Terms and Conditions'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Login Button
                  _isLoading
                      ? const CustomLoadingSpinner(color: AppTheme.blackColor)
                      : CustomButton(
                          text: 'Login',
                          onPressed: _acceptTerms
                              ? _login
                              : () => Fluttertoast.showToast(
                                    msg:
                                        'Please accept the Terms and Conditions to continue',
                                  ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
