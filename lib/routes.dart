import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/product_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/treatment_screen.dart';

class Routes {
  static const String login = '/login';
  static const String home = '/home';
  static const String product = '/product';
  static const String treatment = '/treatment';
  static const String profile = '/profile';

  // Rute yang akan digenerate
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case product:
        return MaterialPageRoute(builder: (_) => ProductScreen());
      case treatment:
        return MaterialPageRoute(builder: (_) => TreatmentScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => LoginScreen());
    }
  }
}
