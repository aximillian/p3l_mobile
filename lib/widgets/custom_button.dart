import 'package:flutter/material.dart';
import 'package:p3l_mobile/theme/app_theme.dart';

// Widget untuk ElevatedButton yang dapat digunakan di berbagai tempat
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color textColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonColor = AppTheme.blackColor, // Default button color
    this.textColor = AppTheme.whiteColor, // Default text color
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor, // Set button color
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor), // Set text color
      ),
    );
  }
}
