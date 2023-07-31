import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RoomDropdown extends StatefulWidget {
  @override
  _RoomDropdownState createState() => _RoomDropdownState();
}

class _RoomDropdownState extends State<RoomDropdown> {
  List<String> _rooms = [];
  String? _selectedRoom;

  @override
  void initState() {
    super.initState();
    fetchRooms();
  }

  Future<void> fetchRooms() async {
    try {
      var response = await http.get(Uri.parse("http://10.5.0.89/bookings/rooms.php"));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<dynamic> rooms = data['rooms'];

        setState(() {
          _rooms = rooms.map((room) => room['room_name'].toString()).toList();
        });
      } else {
        print('Failed to fetch rooms. Error code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _onRoomSelected(String? room) {
    setState(() {
      _selectedRoom = room;
    });
    // Perform any additional actions based on the selected room
    // ...
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedRoom,
          onChanged: _onRoomSelected,
          items: _rooms.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          hint: Text('Select a room'),
        ),
      ),
    );
  }
}