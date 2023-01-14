import 'package:flutter/material.dart';
import 'package:booking2/navbar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: Center(
            child:Column(
              children: [
                Text('Welcome')
              ],
            ),
          ),
        ),
      ),


    );

  }
}

