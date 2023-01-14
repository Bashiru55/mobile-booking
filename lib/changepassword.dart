import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  TextEditingController old_password = TextEditingController();

  TextEditingController new_password = TextEditingController();
  TextEditingController confirm_password = TextEditingController();


  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 10.0),
            child: Column(
                children: <Widget>[
                  const SizedBox(height: 5,),
                  Center(
                      child: Image.asset('assets/images/index.png', height: 220, width: 350,)
                  ),
                  const SizedBox(height: 5,),
                  const Center(
                    child: Text.rich(
                        TextSpan(
                          text: 'CHANGE PASSWORD',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black,),
                        ),

                    ),

                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please Enter Old Password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'OLD PASSWORD',
                      hintText: 'Please Enter Old Password',
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
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please Enter New Password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'NEW PASSWORD',
                      hintText: 'Please Enter New Password',
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
                  const SizedBox(height: 20,),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please Confirm Password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'CONFIRM PASSWORD',
                      hintText: 'Please Confirm Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      labelStyle: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                      ),
                    ),
                  ),
                  const SizedBox(height: 25,),
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
                            )
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[



                        ],
                      )
                    ],
                  ),
            ),
          );

  }
}

