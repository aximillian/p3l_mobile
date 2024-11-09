import 'package:flutter/material.dart';

// Widget untuk loading spinner (opsional)
class CustomLoadingSpinner extends StatelessWidget {
  const CustomLoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
