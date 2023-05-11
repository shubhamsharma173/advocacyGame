import 'package:flutter/material.dart';
import 'thankyou.dart';

class BrandScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Navigate to the next page when the icon is tapped
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ThankYouScreen()));
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/brand_bg.jpg'),
                  // Replace this with your desired background image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
