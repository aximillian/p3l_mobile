import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p3l_mobile/theme/app_theme.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback? onTap;
  final Widget? leading;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;

  const ProfileCard({
    super.key,
    required this.title,
    required this.value,
    this.onTap,
    this.leading,
    this.titleStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12.0),
        leading: leading,
        title: Text(
          title,
          style: titleStyle ?? GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.blackColor,
          ),
        ),
        subtitle: Text(
          value,
          style: valueStyle ?? GoogleFonts.lato(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}