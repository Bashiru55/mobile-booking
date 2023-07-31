import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';

class ChangeUserRole extends StatefulWidget {
  @override
  State<ChangeUserRole> createState() => ChangeUserRoleState();
}

class ChangeUserRoleState extends State<ChangeUserRole> {
  TextEditingController staff_id = TextEditingController();
  TextEditingController User_role = TextEditingController();

  String? selectedUserroles;
  List<String> _userrole =[];

@override
void initState() {
  super.initState();
  fetchUserroles();
}

  Future<void> fetchUserroles() async {
    try {
      var response = await http.get(Uri.parse("http://10.5.0.89/bookings/userroles.php"));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<dynamic> userroles = data['userroles'];

        setState(() {
          _userrole = userroles.map((role) => role['role_name'].toString()).toList();
        });
      } else {
        print('Failed to fetch role. Error code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  void onUserrolesSelected(String? userroles) {
    setState(() {
      selectedUserroles = userroles;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFffffff),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Container(
            child: Form(
              child: ListView(
                  children: <Widget>[
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                        child: Image.asset(
                      'assets/images/index.png',
                      height: 220,
                      width: 350,
                    )),
                    const SizedBox(
                      height: 5,
                    ),
                    const Center(
                      child: Text.rich(TextSpan(
                        text: 'CHANGE USER ROLE',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: <Widget>[
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Staff_id";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'STAFF ID',
                            hintText: 'STAFF ID',
                            border: OutlineInputBorder(
                                // borderRadius: BorderRadius.circular(5.0)
                                ),
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Center(
                            child: Container(
                              width: 600,
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 2.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: selectedUserroles,
                                    onChanged: onUserrolesSelected,
                                    items: _userrole.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),

                                  ),

                              ),
                          ),
                            ),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.only(left: 100,right: 100),
                          child: Container(
                            height: 55.0,
                            width: 300.0,
                            child: Material(
                                borderRadius: BorderRadius.circular(30.0),
                                shadowColor: Colors.greenAccent,
                                color: Colors.green,
                                elevation: 10.0,
                                child: const Center(
                                  child: Text(
                                    'SUBMIT',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[],
                        )
                      ],
                    ),
              ]
                  ),

            ),
          ),
        ),
        );
  }
}
