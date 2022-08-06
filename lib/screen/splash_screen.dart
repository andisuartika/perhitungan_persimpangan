import 'dart:async';

import 'package:flutter/material.dart';
import 'package:perhitungan_persimpangan/screen/home_screen.dart';
import 'package:perhitungan_persimpangan/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () => Navigator.pushNamed(context, '/home'));
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo.png",
              width: 100,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Perhitungan\n Persimpangan",
              style: whiteTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
