import 'package:flutter/material.dart';
import 'package:p3l_mobile/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart'; // Import GoogleFonts

// Widget untuk ElevatedButton yang dapat digunakan di berbagai tempat
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color textColor;
  final double textSize;
  final double buttonWidth;
  final double buttonHeight;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonColor = AppTheme.blackColor, // Default button color
    this.textColor = AppTheme.whiteColor, // Default text color
    this.textSize = 16.0, // Default text size
    this.buttonWidth = double.infinity, // Default button width
    this.buttonHeight = 50.0, // Default button height
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor, // Set button color
        ),
        child: Text(
          text,
          style: GoogleFonts.lato( // Apply GoogleFonts.lato
            color: textColor, // Set text color
            fontSize: textSize, // Set text size
          ),
        ),
      ),
    );
  }
}
