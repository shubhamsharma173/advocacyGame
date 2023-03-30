import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'dart:math';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/welcome_bg.png'),
                // Replace this with your desired background image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(0),
                primary: Colors.transparent,
                onPrimary: Colors.white,
                elevation: 5,
              ),
              child: Container(
                padding: EdgeInsets.only(top: 3),
                width: 80,
                height: 35,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(134, 99, 66, 1),
                      Color.fromRGBO(247, 222, 132, 1),
                      Color.fromRGBO(247, 222, 132, 1),
                      Color.fromRGBO(247, 222, 132, 1),
                      Color.fromRGBO(134, 99, 66, 1),
                    ],
                    stops: [
                      0.01,
                      0.2,
                      0.5,
                      0.7,
                      0.95,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    transform: GradientRotation(170 * (pi / 180)),
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Center(
                  child: Text(
                    'NEXT',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'CustomFont',
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
            left: (screenWidth / 5) - 40,
            top: 240.0, // set the top position
          ),
        ],
      ),
    );
  }
}
