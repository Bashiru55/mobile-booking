import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  Dio dio = Dio();
  TextEditingController staff_id= TextEditingController();
  TextEditingController password= TextEditingController();
  Future<String> login() async {
    var url = "http://10.5.0.18/bookings/tbl_users.php";
    var response = await http.post(Uri.parse(url), body: {
      "staff_id": staff_id.text,
      "password": password.text
    });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data == "success") {
        return "success";
      } else {
        return "error";
      }
    } else {
      return "error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFffffff),
        resizeToAvoidBottomInset : false,
        body: Container(
          child: Form(
            key: formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 40,),
                  Center(
                      child: Image.asset('assets/images/index.png', height: 220, width: 350,)
                  ),
                  const SizedBox(height: 10,),
                  Center(
                    child: Text('Welcome To Ghana Forestry Commission Availability Portal',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold

                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 40, right: 40, top: 40),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Enter StaffID",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.account_circle_rounded),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 40, right: 40, top: 30),
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Enter Password",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: Icon(Icons.remove_red_eye),
                      ),
                    ),
                  ),

                  SizedBox(height: 50,),
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
                            child: GestureDetector(
                                // onTap: ()async {
                                //   if(formKey.currentState!.validate()) {
                                //     var staffId = staff_id.text;
                                //     var Password = password.text;
                                //     var data = await tblusers(
                                //       staffId, Password);
                                //     if (data['success']) {
                                //       // Navigator.push(
                                //       //     context, MaterialPageRoute(
                                //       //     builder: (_) => Dashboard(
                                //       //         // data:staffId
                                //       //     )));
                                //     } else
                                //         {
                                //       ScaffoldMessenger.of(context).showSnackBar(
                                //           const SnackBar(content: Text('Incorrect Staff_id or Password')));
                                //     }
                                //   }
                                //
                                //   // Navigator.push(
                                //   //     context, MaterialPageRoute(builder: (_) => const MyHomePage()));
                                // },
                                child:
                                Center(
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  ),
                                )
                            ),
                          ),
                      ),
                      const SizedBox(height: 25,),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: <Widget>[
                      //   ],
                      // )
                    ],
                  ),

            ),
          ),
        );
  }
  // Future LoginUser() async{
  //   String url = "http://10.5.4.10/bookings/tbl_users.php?";
  //
  //
  //   Map mapeddate={
  //     'staff_id':staff_id.text,
  //     'password':password.text,
  //   };
  //   print("JSON DATA:${mapeddate}");
  //
  //
  //   final response = await http.get(Uri.parse(url),);
  //
  //   var data = jsonDecode(response.body);
  //   print("DATA:${data}");
  // }
}
