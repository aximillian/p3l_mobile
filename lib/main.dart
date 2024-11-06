import 'package:flutter/material.dart';
import 'routes.dart'; // File yang mengelola rute aplikasi

// Navigator
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Flutter Navigation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      
      initialRoute: Routes.login, 
      onGenerateRoute: Routes.generateRoute,
      navigatorKey: navigatorKey, 
    );
  }
}
