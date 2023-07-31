import 'package:booking2/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'BookingModel.dart';
import 'package:dio/dio.dart';
import 'sharedpref.dart';
import 'package:http/http.dart' as http;

class BookingModels {
  List<BookingModel>? bookings;
}

class Booking extends StatefulWidget {
  @override
  BookingState createState() => BookingState();
}

class BookingState extends State<Booking> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  List<BookingModel>? _bookingModel;
  TextEditingController purpose = TextEditingController();
  TextEditingController Startdate = TextEditingController();
  TextEditingController Enddate = TextEditingController();
  TextEditingController roomName = TextEditingController();
  TextEditingController departmentName = TextEditingController();
  TextEditingController meetingtime = TextEditingController();
  TextEditingController NumberOfParticipant = TextEditingController();

  String? staffId;
  String? selectedDepartment;
  String? _selectedRoom;
  String? selectedTime = "Morning";
  List<String> _department = [];
  List<String> _room = [];
  List<String> time = ['Morning', 'Afternoon', 'Full Day'];
  late bool showprogress = false;

  @override
  void initState() {
    super.initState();
    SharedPref.initialize();
    SharedPref.getInstance().then((sharedPref) => null);
    fetchRooms();
    fetchDepartment();
    _bookingModel = [
      BookingModel(
        room: 'room',
        meetingtime: 'meetingtime',
        purpose: 'purpose',
        startdate: 'startdate',
        enddate: 'enddate',
        department: 'department',
        no_of_participant: null,
      )
    ];
  }

  Future<void> fetchDepartment() async {
    try {
      var response = await Dio().get("http://10.5.0.132/bookings/department.php");

      if (response.statusCode == 200) {
        var data = json.decode(response.data);
        List<dynamic> departmentList = data['department'];

        setState(() {
          _department = departmentList
              .map((department) => department['department_name'].toString())
              .toList();
        });
      } else {
        print(
            'Failed to fetch department. Error code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void onDepartmentSelected(String? department) {
    setState(() {
      selectedDepartment = department;
    });
  }

  Future<void> fetchRooms() async {
    try {
      var response = await Dio().get("http://10.5.0.132/bookings/rooms.php");

      if (response.statusCode == 200) {
        var data = json.decode(response.data);
        List<dynamic> rooms = data['rooms'];

        setState(() {
          _room = rooms.map((room) => room['room_name'].toString()).toList();
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
    SharedPref.getInstance().then((sharedPref) {
      sharedPref.storeRoomName(room ?? '');
    });
  }

  Future<void> submitBooking() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();

      setState(() {
        showprogress = true;
      });

      try {
        await createBooking(
          purpose.text,
          Startdate.text,
          Enddate.text,
          _selectedRoom,
          selectedDepartment,
          selectedTime,
          NumberOfParticipant.text,
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Dashboard(),
          ),
        );
      } catch (error) {
        // Handle error during booking creation
        print('Failed to create booking: $error');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to create booking. Please try again.'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } finally {
        setState(() {
          showprogress = false;
        });
      }
    }
  }
  Future<void> createBooking(
      String? purpose,
      String? startDate,
      String? endDate,
      String? room,
      String? department,
      String? meetingTime,
      String? numberOfParticipants,
      ) async {
    String url = "http://10.5.0.132/bookings/bookings.php";
    var response = await http.post(
      Uri.parse(url),
      body: {
        "purpose": purpose,
        "startdate": startDate,
        "enddate": endDate,
        "room_name": room,
        "department": department,
        "meetingtime": meetingTime,
        "numberofparticipant": numberOfParticipants,
      },
    );
    if (response.statusCode == 200) {
      // Booking created successfully
      print('Booking created successfully');
    } else {
      // Booking creation failed
      throw Exception(
          'Failed to create booking. Error code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        child: Column(
          children: <Widget>[
            const Center(
              child: Text.rich(
                TextSpan(
                  text: 'BOOK A ROOM',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: purpose,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Purpose Of Meeting";
                          }
                          return null;
                        },
                        onSaved: (value) => _bookingModel![0].purpose = value,
                        decoration: InputDecoration(
                          labelText: 'Purpose',
                          hintText: 'Purpose of Meeting',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          labelStyle: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0, right: 10),
                              child: TextFormField(
                                controller: Startdate,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Select Start Date';
                                  }
                                  return null;
                                },
                                onSaved: (value) => _bookingModel![0].startdate = value,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.calendar_month_outlined),
                                  labelText: 'Start date',
                                  hintText: 'Select date',
                                  border: OutlineInputBorder(),
                                  labelStyle: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                onTap: () async {
                                  DateTime? pickeddate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickeddate != null) {
                                    setState(() {
                                      Startdate.text =
                                          DateFormat('yyy-MM-dd').format(pickeddate);
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 2.0),
                              child: TextFormField(
                                controller: Enddate,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Select End Date';
                                  }
                                  return null;
                                },
                                onSaved: (value) => _bookingModel![0].enddate = value,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.calendar_month_outlined),
                                  labelText: 'End Date',
                                  hintText: 'Select date',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  labelStyle: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                onTap: () async {
                                  DateTime? pickeddate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickeddate != null) {
                                    setState(() {
                                      Enddate.text =
                                          DateFormat('yyy-MM-dd').format(pickeddate);
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0, right: 0.0),
                              child: GestureDetector(
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _selectedRoom,
                                      onChanged: _onRoomSelected,
                                      items: _room.map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 2.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: selectedDepartment,
                                    onChanged: onDepartmentSelected,
                                    items: _department.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 2.0),
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'Meeting Time',
                                  hintText: 'Select Meeting Time',
                                  border: OutlineInputBorder(),
                                ),
                                items: time.map((String time) {
                                  return DropdownMenuItem<String>(
                                    value: time,
                                    child: Text(time),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedTime = newValue!;
                                  });
                                },
                                value: selectedTime,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 2.0),
                              child: TextFormField(
                                controller: NumberOfParticipant,
                                decoration: InputDecoration(
                                  labelText: 'Number Of Participant',
                                  hintText: ' Enter Number Of Participant',
                                  border: OutlineInputBorder(),
                                  labelStyle: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(left: 100, right: 100),
                        child: Container(
                          height: 55.0,
                          width: 300.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(30.0),
                            shadowColor: Colors.greenAccent,
                            color: Colors.green,
                            elevation: 10.0,
                            child: ElevatedButton(
                              onPressed: () => submitBooking(),
                              child: Center(
                                child: Text(
                                  'SUBMIT',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
