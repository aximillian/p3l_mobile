import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p3l_mobile/theme/app_theme.dart';
import 'package:p3l_mobile/entity/ruangan.dart';
import 'package:p3l_mobile/services/ruangan_service.dart';

class UpdateRoomScreen extends StatefulWidget {
  @override
  _UpdateRoomScreenState createState() => _UpdateRoomScreenState();
}

class _UpdateRoomScreenState extends State<UpdateRoomScreen> {
  final _formKey = GlobalKey<FormState>();
  List<Ruangan> _rooms = [];
  bool _isLoading = false;
  final _ruanganService = RuanganService();

  @override
  void initState() {
    super.initState();
    _fetchRuangans();
  }

  // Fetch rooms from the API
  Future<void> _fetchRuangans() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<Ruangan> rooms = await _ruanganService.fetchRuangans();
      setState(() {
        _rooms = rooms;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to load rooms: $e'),
      ));
    }
  }

  // Update the room status
  Future<void> _updateRoomStatus(Ruangan room, String newStatus) async {
    try {
      await _ruanganService.updateRoomStatus(room.id, newStatus);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Room ${room.nomorRuangan} status updated to $newStatus'),
      ));
      _fetchRuangans(); // Re-fetch the rooms to reflect the changes
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update status: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Room Status',
          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppTheme.pinkColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Loading indicator while fetching rooms
            if (_isLoading)
              CircularProgressIndicator()
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _rooms.length,
                  itemBuilder: (context, index) {
                    final room = _rooms[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        title: Text('Room No: ${room.nomorRuangan}'),
                        subtitle: Text('Current Status: ${room.status}'),
                        trailing: DropdownButton<String>(
                          value: room.status,
                          items: ['available', 'booked'].map((String status) {
                            return DropdownMenuItem<String>(
                              value: status,
                              child: Text(status),
                            );
                          }).toList(),
                          onChanged: (String? newStatus) {
                            if (newStatus != null) {
                              _updateRoomStatus(room, newStatus);
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
