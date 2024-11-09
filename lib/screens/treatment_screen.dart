import 'package:flutter/material.dart';
import 'package:p3l_mobile/widgets/bottom_navbar.dart';

class TreatmentScreen extends StatelessWidget {
  const TreatmentScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Informasi tentang Perawatan')),

      bottomNavigationBar: BottomNavBar(),
    );
  }
}
