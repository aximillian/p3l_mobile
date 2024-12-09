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

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _textController;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();
    _textController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _textAnimation = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );

    _textController.forward();

    _startSplashScreen();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
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
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // Logo
                  ClipOval(
                    child: Image.asset(
                      'assets/images/logo.jpg',
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title 
                  FadeTransition(
                    opacity: _textAnimation,
                    child: Text(
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
                  ),
                  const SizedBox(height: 80),
                  
                ],
              ),
            ),
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
