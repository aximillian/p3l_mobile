import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p3l_mobile/theme/app_theme.dart';

class UpdateRoomScreen extends StatefulWidget {
  @override
  _UpdateRoomScreenState createState() => _UpdateRoomScreenState();
}

class _UpdateRoomScreenState extends State<UpdateRoomScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _roomNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Room',
          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppTheme.pinkColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Room Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a room number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _roomNumber = value;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateRoom,
                child: Text('Update Room'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.pinkColor, 
                  textStyle: GoogleFonts.lato(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateRoom() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Implement the logic to update the room number
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Room number updated to $_roomNumber')),
      );
    }
  }
}