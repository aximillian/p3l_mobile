import 'dart:async';
import 'package:flutter/material.dart';
import 'package:p3l_mobile/screens/home_screen.dart';
import 'package:p3l_mobile/theme/app_theme.dart';
import 'package:p3l_mobile/widgets/custom_loading_spinner.dart';
import 'package:google_fonts/google_fonts.dart';

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
          builder: (context) => const HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [

          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Background effect
          Container(
            color: AppTheme.blackColor.withOpacity(0.6),
          ),

          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Logo
              Image.asset(
                'assets/images/image.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 40),

              // Title 
              Text(
                'Your Journey to\nTimeless Beauty\nBegins Here',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  color: AppTheme.pinkColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  shadows: const [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black45,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80),
              
            ],
          ),

          // Loading spinner
          const Positioned(
            bottom: 150, 
            left: 0,
            right: 0,
            child: CustomLoadingSpinner(color: AppTheme.pinkColor),
          ),
        ],
      ),
    );
  }
}
