import 'package:flutter/material.dart';
class Logout extends StatefulWidget{
  @override
  LogoutState createState()=> LogoutState();


}
class LogoutState extends State<Logout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
        child: Center(
          child: Text('Logout',
            style: TextStyle(
                fontSize: 15
            ),),
        )
    );
  }
}