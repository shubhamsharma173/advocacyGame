import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class ThankYouScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thank You'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Thank you for registering!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      (route) => false,
                );
              },
              child: Text('Back to Welcome Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
