import 'package:flutter/material.dart';
import 'package:p3l_mobile/screens/login_screen.dart';
import 'package:p3l_mobile/screens/home_screen.dart';
import 'package:p3l_mobile/screens/product_screen.dart';
import 'package:p3l_mobile/screens/splash_screen.dart';
import 'package:p3l_mobile/screens/treatment_screen.dart';
import 'package:p3l_mobile/screens/profile_screen.dart';
import 'package:p3l_mobile/screens/schedule_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String produk = '/produk';
  static const String perawatan = '/perawatan';
  static const String jadwal = '/jadwal';
  static const String profile = '/profile';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splash:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case AppRoutes.login:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case AppRoutes.home:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case AppRoutes.produk:
      return MaterialPageRoute(builder: (_) => const ProductScreen());
    case AppRoutes.perawatan:
      return MaterialPageRoute(builder: (_) => const TreatmentScreen());
    case AppRoutes.jadwal:
      return MaterialPageRoute(builder: (_) => const ScheduleScreen());
    case AppRoutes.profile:
      return MaterialPageRoute(builder: (_) => const ProfileScreen());
    default:
      return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))));
  }
}
