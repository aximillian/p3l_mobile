import 'package:flutter/material.dart';
import 'package:p3l_mobile/widgets/bottom_navbar.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('List of Products'),
      ),

    bottomNavigationBar: BottomNavBar(),
    );
  }
}
