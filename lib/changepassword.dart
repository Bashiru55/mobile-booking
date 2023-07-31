import 'package:booking2/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:logger/logger.dart';


class ChangePassword extends StatefulWidget{
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}
class _ChangePasswordState extends State<ChangePassword> {
  var _newpassword = TextEditingController();
  var _confirmpassword = TextEditingController();
  late String newpassword, confirmpassword;
  bool isLoading = false;
  String errorMessage = '';
  late bool error, showprogress, success;
  var logger = Logger();

    startChange(BuildContext context) async {
      setState(() {
        isLoading = true;
      });

    String url = "http://10.5.0.89/bookings/changepassword.php";
    print(newpassword);
    print(confirmpassword);

    var response = await post(Uri.parse(url), body: {
      'newpassword': newpassword,
      'confirmpassword': confirmpassword
    });

    logger.d(response.body);

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);

      if (jsondata['success']?.toString()?.toLowerCase()== 'true') {
        // Password changed successfully
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
            content: const Text('Password changed successfully'),
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
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 5,),
            Center(
                child: Image.asset(
                  'assets/images/index.png', height: 220, width: 350,)
            ),
            const SizedBox(height: 5,
            ),
            const Center(
              child: Text.rich(
                TextSpan(
                  text: 'CHANGE PASSWORD',
                  style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'NEW PASSWORD',
                hintText: 'Please Enter New Password',
                border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.remove_red_eye),
                labelStyle: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                ),
              ),
            ),
            const SizedBox(height: 50,),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'CONFIRM PASSWORD',
                hintText: 'Please Confirm Password',
                border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.remove_red_eye),
                labelStyle: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                ),
              ),
            ),
            const SizedBox(height: 25,),
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
                      onPressed: (){
                        setState(() {
                          showprogress = true;
                        });
                        newpassword = _newpassword.text;
                        confirmpassword = _confirmpassword.text;
                        startChange(context);
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
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
