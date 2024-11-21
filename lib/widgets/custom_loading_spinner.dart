import 'package:flutter/material.dart';
import 'package:p3l_mobile/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart'; // Import GoogleFonts

// Widget untuk loading spinner (opsional)
class CustomLoadingSpinner extends StatelessWidget {
  final Color color;

  const CustomLoadingSpinner({super.key, this.color = AppTheme.blackColor});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(color)),
          const SizedBox(height: 20),
          Text(
            'Loading...',
            style: GoogleFonts.lato(
              textStyle: TextStyle(color: color, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
