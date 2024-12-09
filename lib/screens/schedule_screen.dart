import 'package:flutter/material.dart';
import 'package:p3l_mobile/widgets/bottom_navbar.dart';
import 'package:p3l_mobile/theme/app_theme.dart';
import 'package:p3l_mobile/data/schedule_data.dart';
import 'package:p3l_mobile/widgets/schedule_card.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  bool _showDropdown = false;
  String _selectedDay = 'All Days';
  final List<String> _days = ['All Days', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Schedule',
          style: GoogleFonts.lato(),
        ),
        backgroundColor: AppTheme.pinkColor,
        elevation: 10, 
        shadowColor: Colors.black.withOpacity(0.5), 
        automaticallyImplyLeading: false,
      ),
      
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.pinkColor, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Doctor Schedule',
                  style: GoogleFonts.lato(fontSize: 24.0, fontWeight: FontWeight.bold, color: AppTheme.blackColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.whiteColor,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: DropdownButton<String>(
                        value: _selectedDay,
                        dropdownColor: AppTheme.whiteColor,
                        iconEnabledColor: AppTheme.blackColor,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedDay = newValue!;
                            _showDropdown = true;
                          });
                        },
                        items: _days.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: AppTheme.blackColor),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              _showDropdown ? _buildDoctorSchedule(_selectedDay) : _buildDoctorSchedule(''),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Beautician Schedule',
                  style: GoogleFonts.lato(fontSize: 24.0, fontWeight: FontWeight.bold, color: AppTheme.blackColor),
                ),
              ),
              _showDropdown ? _buildBeauticianSchedule(_selectedDay) : _buildBeauticianSchedule(''),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget _buildDoctorSchedule(String day) {
    if (day == 'All Days' || day.isEmpty) {
      return Column(
        children: doctorSchedule.entries.map((entry) {
          return ScheduleCard(day: entry.key, daySchedule: entry.value);
        }).toList(),
      );
    } else {
      return _buildSchedule(doctorSchedule[day] ?? {});
    }
  }

  Widget _buildBeauticianSchedule(String day) {
    if (day == 'All Days' || day.isEmpty) {
      return Column(
        children: beauticianSchedule.entries.map((entry) {
          return ScheduleCard(day: entry.key, daySchedule: entry.value);
        }).toList(),
      );
    } else {
      return _buildSchedule(beauticianSchedule[day] ?? {});
    }
  }

  Widget _buildSchedule(Map<String, List<String>> daySchedule) {
    return Column(
      children: daySchedule.entries.map((entry) {
        return ScheduleCard(day: entry.key, daySchedule: {entry.key: entry.value});
      }).toList(),
    );
  }
}