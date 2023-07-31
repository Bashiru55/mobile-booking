import 'package:booking2/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:logger/logger.dart';

class ResetPassword extends StatefulWidget {

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  var _staff_id = TextEditingController();
  late String staff_id;
  bool isLoading = false;
  String errorMessage = '';
  late bool error, showprogress, success;
  var logger = Logger();

  startReset(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    String url = "http:// 10.5.0.89/bookings/resetpassword.php";
    print(staff_id);

    var response = await post(Uri.parse(url), body: {
      'staff_id': staff_id,

    });
    logger.d(response.body);

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata['success']?.toString()?.toLowerCase()== 'true') {
        // Password Reset successfully
        _showSuccessDialog();
      } else if (jsondata['success']?.toString()?.toLowerCase()=='error'){
        // Error changing password
        setState(() {
          showprogress = false;
          errorMessage = 'Failed to change password';
        });
      }
    } else {
      // Error connecting to server
      setState(() {
        errorMessage = 'Connection error. Please try again later';
        isLoading = false;
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            title: const Text('Success'),
            content: const Text('Password Reset successfully'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(
                    context, MaterialPageRoute(builder: (context)=>Home()),
                    // Navigator.pop(context); // Go back to previous screen
                  );
                },
                child: const Text('SUBMIT'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 10,right: 10),
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 5,),
              Center(
                  child: Image.asset('assets/images/index.png', height: 220, width: 350,)
              ),
              const SizedBox(height: 5,),
              const Center(
                child: Text.rich(
                  TextSpan(
                    text: 'RESET PASSWORD',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black,),
                  ),

                ),

              ),
              const SizedBox(height: 20,),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return "Please Enter Staff_id";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'STAFF ID',
                  hintText: 'STAFF ID',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  labelStyle: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                  ),
                ),
              ),
              const SizedBox(height: 10),
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

                              child:ElevatedButton(
                              onPressed: (){
                                setState(() {
                                  showprogress = true;
                                });
                              staff_id = _staff_id.text;
                                startReset(context);

                                },
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
                      )
                    ],
                  ),

            ),
    );

  }
}
