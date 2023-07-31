import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/src/material/dropdown.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => AddUserState();
}

class AddUserState extends State<AddUser> {
  TextEditingController staff_id = TextEditingController();
  TextEditingController User_role = TextEditingController();

  String? selectedUserroles;
  List<String> userrole =[];
  @override
  void initState(){
    super.initState();
    fetchUserroles();
  }
  Future<void> fetchUserroles() async {
    try {
      var response = await http.get(Uri.parse("http://10.5.0.194/bookings/userroles.php"));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<dynamic> userroles = data['userroles'];
        setState(() {
          userrole = userroles.map((role) => role['role_id'].toString()).toList();
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
      print( selectedUserroles);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 10,right: 10),
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
              child: Text.rich(
                TextSpan(
                  text: 'ADD USER',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter Staff_id";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'STAFF ID',
                hintText: 'STAFF ID',
                border: OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(5.0)
                    ),
                labelStyle: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
            const SizedBox(height: 25),
            Center(
              child:
                Container(
                  width: 600,
                  height: 60,
                   decoration: BoxDecoration(
                   border: Border.all(color: Colors.black38, width:3),
                   color: Colors.grey.shade50,
                   ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 2.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedUserroles,
                        onChanged: onUserrolesSelected,
                        items: userrole.map<DropdownMenuItem<String>>((String value) {
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
            Center(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[],
            )
          ],
        ),
      ),
    );
  }
}


