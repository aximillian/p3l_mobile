import 'dart:async';
import 'package:flutter/material.dart';
import 'package:p3l_mobile/theme/app_theme.dart';
import 'login_screen.dart';
import 'package:p3l_mobile/widgets/custom_loading_spinner.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startSplashScreen();
  }

  void _startSplashScreen() {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) =>
                const LoginScreen()), 
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pinkColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/image.png', 
              width: 300, 
              height: 300, 
            ),
            const SizedBox(height: 100),  
            const CustomLoadingSpinner(), 
          ],
        ),
      ),
    );
  }
}
