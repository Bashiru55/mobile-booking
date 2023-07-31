import 'package:booking2/login_page.dart';
import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Are you sure you want to log out?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement logout functionality
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => LoginPage())); // Return true to indicate success
              },
              child: Text('Yes, log out'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => LoginPage()));// Return false to indicate cancellation
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
