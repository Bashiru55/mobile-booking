import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => ResetPasswordState();
}

class ResetPasswordState extends State<ResetPassword> {
  TextEditingController staff_id = TextEditingController();

  @override
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
                      const SizedBox(height: 25,),
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
