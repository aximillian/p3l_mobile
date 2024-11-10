import 'package:flutter/material.dart';
import 'package:p3l_mobile/theme/app_theme.dart';

// Widget untuk loading spinner (opsional)
class CustomLoadingSpinner extends StatelessWidget {
  final Color color;

  const CustomLoadingSpinner({super.key, this.color = AppTheme.blackColor});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(color)),
    );
  }
}
