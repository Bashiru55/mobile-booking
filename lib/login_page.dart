// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dashboard.dart';
//
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   TextEditingController staff_id= TextEditingController();
//   TextEditingController password= TextEditingController();
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   Future<String> login() async {
//     var url = "http://10.5.0.18/bookings/tbl_users.php";
//     var response = await http.post(Uri.parse(url), body: {
//       "staff_id": staff_id.text,
//       "password": password.text
//     });
//
//     if (response.statusCode == 200) {
//       var data = json.decode(response.body);
//       if (data == "success") {
//         return "success";
//       } else {
//         return "error";
//       }
//     } else {
//       return "error";
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: Text("Login"),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               keyboardType: TextInputType.number,
//               controller: staff_id,
//               decoration: InputDecoration(
//                 labelText: "staff_id",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(
//               height: 16,
//             ),
//             TextField(
//               controller: password,
//               decoration: InputDecoration(
//                 labelText: "Password",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(
//               height: 16,
//             ),
//             ElevatedButton(
//               child: Text("Login"),
//               onPressed: () {
//                 login().then((value) {
//                   if (value == "success") {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text("Login successful!"),
//                       ),
//                     );
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => Dashboard()));
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text("Invalid staff_id or password!"),
//                       ),
//                     );
//                   }
//
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:booking2/estate.dart';
import 'package:booking2/home.dart';
import 'package:booking2/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}
class _LoginPage extends State<LoginPage> {
  late String errormsg;
  late bool isAdmin = true;
  late bool isEstate = true;
  late bool error, showprogress, success;
  late String staff_id, password;
  var logger = Logger();
  var _staff_id = TextEditingController();
  var _password = TextEditingController();

  startLogin(BuildContext context) async {
    String url = "http://10.5.0.132/bookings/tbl_users.php"; //api url

    print(staff_id);
    print(password);

    var response = await http.post(Uri.parse(url), body: {
      'staff_id': staff_id, //get the username text
      'password': password //get password text
    });
    logger.d(response.body);
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata ["success"]?.toString()?.toLowerCase() == "true") {
        setState(() {
          showprogress = false; //don't show progress indicator
          error = true;
          success = true;

          var roleID = jsondata ["role_id"];
          if(roleID=='0') {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          }else if(roleID=='1'){
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Estate()));
          }else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => User()));
          }

        });

      } else {
        final jsondata = json.decode(response.body);
        if (jsondata["error"]) {
          setState(() {
            error = false;
            showprogress = false;
            errormsg = jsondata["message"];
          });
        }
      }
    } else {
      final jsondata = json.decode(response.body);
      if (jsondata["error"]) {
        setState(() {
          error = false;
          showprogress = false;
          errormsg = jsondata["message"];
        });
      }
    }
  }

  @override
  void initState() {
    staff_id = "";
    password = "";
    errormsg = "";
    error = false;
    showprogress = false;

    super.initState();
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
                  const SizedBox(height: 40,),
                  Center(
                      child: Image.asset(
                        'assets/images/index.png', height: 220, width: 350,)
                  ),
                  const SizedBox(height: 10,),
                  Center(
                    child: Text(
                      'Welcome To Ghana Forestry Commission Availability Portal',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold

                      ),
                    ),
                  ),

                  Container(
                    child: error ? errmsg(errormsg) : Container(),
                  ),

                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 40, right: 40, top: 20),
                        margin: EdgeInsets.only(top: 10),
                        child: TextField(
                          controller: _staff_id, //set username controller
                          decoration: const InputDecoration(
                            labelText: "Enter StaffID",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                          onChanged: (value) {
                            staff_id = value;
                          },

                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.only(left: 40, right: 40, top: 20),
                    child: TextFormField(
                      controller: _password, //set password controller
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Enter Password",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: Icon(Icons.remove_red_eye),
                      ),
                      onChanged: (value) {
                        // change password text
                        password = value;
                      },

                    ),
                  ),

                  SizedBox(height: 50,),

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
                            onPressed: () {
                              setState(() {
                                showprogress = true;
                              });
                              staff_id = _staff_id.text;
                              password = _password.text;
                              startLogin(context);
                            },

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

                  const SizedBox()
                  // Container(
                  //    padding: EdgeInsets.all(10),
                  //   margin: EdgeInsets.only(top:20),
                  //    child: InkResponse(
                  //         onTap:(){
                  //           //action on tap
                  //           },
                  //           child:Text("",
                  //             style: TextStyle(color:Colors.white, fontSize:18),
                  //           )
                  //       ),
                  //     )
                ]),
          )
      ),
    );
  }

  InputDecoration ConstInputDecoration(
      {required String label, required IconData icon}) {
    return InputDecoration(
      hintText: label,
      //show label as placeholder
      hintStyle: TextStyle(color: Colors.white, fontSize: 20),
      //hint text style
      prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20, right: 10),
          child: Icon(icon, color: Colors.black,)
        //padding and icon for prefix
      ),

      contentPadding: EdgeInsets.fromLTRB(30, 20, 30, 20),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.greenAccent, width: 1)
      ),
      //default border of input

      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.green, width: 1)
      ),
      //focus border

      fillColor: Colors.white,
      filled: true, //set true if you want to show input background
    );
  }

  Widget errmsg(String text) {
    //error message widget.
    return Container(
      padding: EdgeInsets.all(15.00),
      margin: EdgeInsets.only(bottom: 10.00),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.greenAccent,
          border: Border.all(color: Colors.green, width: 2)
      ),
      child: Row(children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 6.00),
          child: Icon(Icons.info, color: Colors.white),
        ), // icon for error message

        Text(text, style: TextStyle(color: Colors.white, fontSize: 18)),
        //show error message text
      ]),
    );
  }
}

