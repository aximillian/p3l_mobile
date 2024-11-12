import 'package:flutter/material.dart';
import 'package:p3l_mobile/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'P3L Mobile',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: generateRoute,
    );
  }
}
