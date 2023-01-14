import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => AddUserState();
}

class AddUserState extends State<AddUser> {
  TextEditingController staff_id = TextEditingController();
  TextEditingController User_role = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            TextFormField(
              decoration: InputDecoration(
                labelText: 'USER ROLE',
                hintText: 'Please Select User Role',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                labelStyle: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
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
