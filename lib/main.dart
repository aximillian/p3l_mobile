import 'package:flutter/material.dart';
import 'package:p3l_mobile/theme/app_theme.dart';
import 'routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Natural Beauty Center',
      theme: AppTheme.themeData,
      
      initialRoute: AppRoutes.splash,
      onGenerateRoute: generateRoute,
    );
  }
}
