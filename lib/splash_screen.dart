import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/icons/appIcons/192.png',
            ),
            SizedBox(height: 30),
            Text(
              'RSBS ADVOCACY GAME',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'CustomFont',
                  fontWeight: FontWeight.w800,
                  fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
