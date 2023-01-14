import 'package:flutter/material.dart';


class NavBar extends StatefulWidget{
  @override
  NavBarState createState()=> NavBarState();


}
class NavBarState extends State<NavBar>{
  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.zero,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(image: AssetImage('assets/images/index.png')),
            ),
          ),
          Text('FC AVAILABILITY',
            style: TextStyle(color: Colors.black,
                fontSize: 20),
          ),
          Text('BOOK A ROOM',
            style: TextStyle(color: Colors.black,fontSize: 20),
          ),
        ],
      ),
    );
  }
}