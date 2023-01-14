// import 'dart:html';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';

class ChangeUserRole extends StatefulWidget {
  const ChangeUserRole({Key? key}) : super(key: key);

  @override
  State<ChangeUserRole> createState() => ChangeUserRoleState();
}

class ChangeUserRoleState extends State<ChangeUserRole> {
  TextEditingController staff_id = TextEditingController();

  TextEditingController User_role = TextEditingController();

  String? userRoles;
  List? return_arr = [];

  var data;

  Future getAllUser() async {
    var url = "http://192.168.137.163/userroles.php";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        return_arr = jsonData;
      });
    }

    print(return_arr);
  }

  @override
  void initState() {
    super.initState();
    getAllUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFffffff),
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Form(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 40,
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
                        child: DropdownButton(
                          value: userRoles,
                          hint: const Text('Select User roles'),
                          items: data.map(
                            (list) {
                              return DropdownMenuItem(
                                child: Text(list['role']),
                              );
                            },
                          ),
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
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
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[],
                      )
                    ],
                  ),
                ]),
          ),
        ));
  }
}
