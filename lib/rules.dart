import 'package:flutter/material.dart';
import 'grid1.dart';
import 'dart:math';

class RulesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/rules_bg.png'),
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
                  MaterialPageRoute(builder: (context) => FlashingIconsGrid1()),
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
                width: 150,
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
                    'START THE GAME',
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
            left: (screenWidth / 2) - 75,
            bottom: (screenHeight / 5) - 17.5,
          ),
        ],
      ),
    );
  }
}
