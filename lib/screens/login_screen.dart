import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:p3l_mobile/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/auth_service.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_loading_spinner.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _rememberMe = false;
  bool _acceptTerms = false;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _animateOpacity();
  }

  void _animateOpacity() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

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
      Fluttertoast.showToast(
        msg: 'Welcome back! You have successfully logged in.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 12.0,
      );
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Fluttertoast.showToast(
        msg: response['message'] == 'Unauthorized'
            ? 'You do not have the necessary permissions to access this account.'
            : response['message'] == 'Invalid Credential'
                ? 'The username or password you entered is incorrect.'
                : response['message'],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 12.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.pinkColor, AppTheme.whiteColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(seconds: 1),
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        'assets/images/logo.jpg',
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 10),
                        Text(
                          'Let\'s Get Start Exploring',
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              fontSize: 28,
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
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Sign in with your account',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.blackColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    CustomTextField(
                      controller: _usernameController,
                      labelText: 'Username',
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: _passwordController,
                      labelText: 'Password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),
                    
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
      ),
    );
  }
}
