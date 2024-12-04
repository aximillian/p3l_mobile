import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Add this import
import '../theme/app_theme.dart';

class AboutUsWidget extends StatelessWidget {
  const AboutUsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Us',
            style: GoogleFonts.lato(fontSize: 24.0, fontWeight: FontWeight.bold, color: AppTheme.blackColor),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Natural Beauty Center, the beauty clinic that offers the finest treatments for your skin and body!',
                  style: GoogleFonts.lato(fontSize: 16.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 8),
                Text(
                  'With experienced professionals and state-of-the-art technology, we are here to help you achieve a radiant, natural beauty. At Natural Beauty Center, we believe that every individual\'s uniqueness deserves care and enhancement. Enjoy a personalized and comprehensive experience, from facials and skincare treatments to relaxing body therapies. Trust us with your beauty needs, and feel the real transformation with stunning results!',
                  style: GoogleFonts.lato(fontSize: 14.0),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}