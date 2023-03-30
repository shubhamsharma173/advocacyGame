import 'package:advocacy_game/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math';

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
          Positioned(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(0),
                primary: Colors.transparent,
                onPrimary: Colors.white,
                elevation: 0,
                // set the elevation to 0
                shadowColor:
                    Colors.transparent, // set the shadow color to transparent
              ),
              child: Container(
                width: 30,
                height: 30,
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
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            left: 5,
            top: 5,
          ),
        ],
      ),
    );
  }
}
