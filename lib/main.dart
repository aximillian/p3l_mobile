import 'package:flutter/material.dart';
import 'package:p3l_mobile/screens/home_screen.dart';
import 'package:p3l_mobile/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(), // Halaman setelah login
      },
    );
  }
}
