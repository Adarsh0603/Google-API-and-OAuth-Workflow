import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Spacer(),
            Image.asset(
              'assets/firebaselogo.png',
              scale: 8,
            ),
            Text('Firebase Helper',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            Spacer(),
            LinearProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            )
          ],
        ),
      ),
    );
  }
}
