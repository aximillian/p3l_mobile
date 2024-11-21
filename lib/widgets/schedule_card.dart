import 'package:flutter/material.dart';
import 'package:p3l_mobile/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleCard extends StatelessWidget {
  final String day;
  final Map<String, List<String>> daySchedule;

  const ScheduleCard({required this.day, required this.daySchedule, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              day,
              style: GoogleFonts.lato(fontSize: 20.0, fontWeight: FontWeight.bold, color: AppTheme.blackColor),
            ),
            const Divider(color: AppTheme.blackColor),
            ...daySchedule.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        entry.key,
                        style: GoogleFonts.lato(fontSize: 16.0, fontWeight: FontWeight.w500, color: AppTheme.blackColor),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        entry.value.join(', '),
                        style: GoogleFonts.lato(fontSize: 16.0, color: AppTheme.blackColor),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}