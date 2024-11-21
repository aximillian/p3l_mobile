import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/schedule_data.dart';

class SchedulesWidget extends StatelessWidget {
  const SchedulesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // Adjust height as needed
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildScheduleCard('Doctor Schedule', _buildDoctorSchedule()),
          _buildScheduleCard('Beautician Schedule', _buildBeauticianSchedule()),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(String title, Widget scheduleContent) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Container(
        width: 300, // Adjust width as needed
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.lato(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Expanded(child: scheduleContent),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorSchedule() {
    return ListView(
      shrinkWrap: true,
      children: doctorSchedule.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: GoogleFonts.lato(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              ...entry.value.entries.map((shiftEntry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          shiftEntry.key,
                          style: GoogleFonts.lato(fontSize: 14.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          shiftEntry.value.join(', '),
                          style: GoogleFonts.lato(fontSize: 14.0),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBeauticianSchedule() {
    return ListView(
      shrinkWrap: true,
      children: beauticianSchedule.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: GoogleFonts.lato(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              ...entry.value.entries.map((shiftEntry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          shiftEntry.key,
                          style: GoogleFonts.lato(fontSize: 14.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          shiftEntry.value.join(', '),
                          style: GoogleFonts.lato(fontSize: 14.0),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      }).toList(),
    );
  }
}