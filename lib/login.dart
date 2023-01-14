import 'package:booking2/booking.dart';
import 'package:booking2/dashboard.dart';
import 'package:booking2/login.dart';
import 'package:flutter/material.dart';
import 'auth.api.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();


  TextEditingController staff_id= TextEditingController();

  TextEditingController password= TextEditingController();

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
                  const SizedBox(height: 5,),
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

                  const SizedBox(height: 10),
                        TextFormField(
                          // controller: staff_id,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: 'STAFF ID',
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty ||!RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$').hasMatch(value)){
                              return "Enter a valid Staff ID ";
                            }else{
                              return null;
                            }
                          },
                        ),
                      const SizedBox(height: 25),
                      Container(
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: password,
                          decoration: const InputDecoration(
                            helperText: "",
                            prefixIcon: Icon(Icons.visibility),
                            hintText: 'PASSWORD',
                            hintStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            ),
                          ),
                          obscureText: true,
                          validator: (value){
                            if(value!.isEmpty ||!RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$").hasMatch(value)){
                              return "Enter a correct Password";
                            }else{
                              return null;
                            }
                          },
                        ),
                      ),
                      Container(
                        height: 55.0,
                        width: 300.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(30.0),
                          shadowColor: Colors.greenAccent,
                          color: Colors.green,
                          elevation: 10.0,
                          child: GestureDetector(
                              onTap: ()async {
                                if(formKey.currentState!.validate()) {
                                  var staffId = staff_id.text;
                                  var Password = password.text;
                                  var data = await fetchUsers(
                                    staff_id: staffId,
                                    password: Password,);
                                  if (data['ok']) {
                                    Navigator.push(
                                        context, MaterialPageRoute(
                                        builder: (_) => Dashboard(
                                            // data:staffId
                                        )));
                                  } else
                                      {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Incorrect Password')));
                                  }
                                }


                                // Navigator.push(
                                //     context, MaterialPageRoute(builder: (_) => const MyHomePage()));
                              },
                              child: const Center(
                                child: Text(
                                  'LOGIN',
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
                      const SizedBox(height: 25,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[



                        ],
                      )
                    ],
                  ),

            ),
          ),
        );
  }
}
