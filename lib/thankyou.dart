import 'package:flutter/material.dart';

class ThankYouScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/thanku_bg.png'),
                // Replace this with your desired background image path
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
