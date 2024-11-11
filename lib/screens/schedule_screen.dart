import 'package:flutter/material.dart';
import 'package:p3l_mobile/widgets/bottom_navbar.dart';
import 'package:p3l_mobile/theme/app_theme.dart';

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
        title: const Text('Schedule'),
        backgroundColor: AppTheme.pinkColor,
        elevation: 0,
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
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Doctor Schedule',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: AppTheme.blackColor),
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
                        boxShadow: [
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
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Beautician Schedule',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: AppTheme.blackColor),
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
    final schedule = {
      'Tuesday': {
        'Shift 1 (09:00 - 15:00)': ['Dr. Anita'],
        'Shift 2 (15:00 - 21:00)': ['Dr. Anita'],
      },
      'Wednesday': {
        'Shift 1 (09:00 - 15:00)': ['Dr. Anita'],
        'Shift 2 (15:00 - 21:00)': ['Dr. Becky'],
      },
      'Thursday': {
        'Shift 1 (09:00 - 15:00)': ['Dr. Becky'],
        'Shift 2 (15:00 - 21:00)': ['Dr. Charlie'],
      },
      'Friday': {
        'Shift 1 (09:00 - 15:00)': ['Dr. Anita', 'Dr. Becky'],
        'Shift 2 (15:00 - 21:00)': ['Dr. Becky', 'Dr. Charlie'],
      },
      'Saturday': {
        'Shift 1 (09:00 - 15:00)': ['Dr. Anita', 'Dr. Charlie'],
        'Shift 2 (15:00 - 21:00)': ['Dr. Becky', 'Dr. Charlie'],
      },
      'Sunday': {
        'Shift 1 (09:00 - 15:00)': ['Dr. Anita', 'Dr. Charlie'],
        'Shift 2 (15:00 - 21:00)': ['Dr. Becky', 'Dr. Charlie'],
      },
    };

    if (day == 'All Days' || day.isEmpty) {
      return Column(
        children: schedule.entries.map((entry) {
          return _buildScheduleCard(entry.key, entry.value);
        }).toList(),
      );
    } else {
      return _buildSchedule(schedule[day] ?? {});
    }
  }

  Widget _buildBeauticianSchedule(String day) {
    final schedule = {
      'Tuesday': {
        'Shift 1 (09:00 - 15:00)': ['Audy', 'Cintya', 'Dio'],
        'Shift 2 (15:00 - 21:00)': ['Bella', 'Elisa', 'Fendy'],
      },
      'Wednesday': {
        'Shift 1 (09:00 - 15:00)': ['Audy', 'Elisa', 'Fendy'],
        'Shift 2 (15:00 - 21:00)': ['Bella', 'Elisa', 'Dio'],
      },
      'Thursday': {
        'Shift 1 (09:00 - 15:00)': ['Audy', 'Elisa', 'Dio'],
        'Shift 2 (15:00 - 21:00)': ['Bella', 'Cintya', 'Fendy'],
      },
      'Friday': {
        'Shift 1 (09:00 - 15:00)': ['Audy', 'Cintya', 'Fendy'],
        'Shift 2 (15:00 - 21:00)': ['Bella', 'Cintya', 'Dio'],
      },
      'Saturday': {
        'Shift 1 (09:00 - 15:00)': ['Audy', 'Elisa', 'Dio'],
        'Shift 2 (15:00 - 21:00)': ['Bella', 'Cintya', 'Fendy'],
      },
      'Sunday': {
        'Shift 1 (09:00 - 15:00)': ['Audy', 'Elisa', 'Fendy'],
        'Shift 2 (15:00 - 21:00)': ['Bella', 'Cintya', 'Dio'],
      },
    };

    if (day == 'All Days' || day.isEmpty) {
      return Column(
        children: schedule.entries.map((entry) {
          return _buildScheduleCard(entry.key, entry.value);
        }).toList(),
      );
    } else {
      return _buildSchedule(schedule[day] ?? {});
    }
  }

  Widget _buildScheduleCard(String day, Map<String, List<String>> daySchedule) {
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
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: AppTheme.blackColor),
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
                        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: AppTheme.blackColor),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        entry.value.join(', '),
                        style: const TextStyle(fontSize: 16.0, color: AppTheme.blackColor),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSchedule(Map<String, List<String>> daySchedule) {
    return Column(
      children: daySchedule.entries.map((entry) {
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
                  entry.key,
                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: AppTheme.blackColor),
                ),
                const Divider(color: AppTheme.blackColor),
                ...entry.value.map((name) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: AppTheme.blackColor),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}