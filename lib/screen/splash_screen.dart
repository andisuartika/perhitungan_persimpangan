import 'dart:async';

import 'package:flutter/material.dart';
import 'package:perhitungan_persimpangan/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    cekLogin();
    super.initState();
  }

  cekLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool isLogin = prefs.getBool('isLogin') ?? false;

    isLogin
        ? Navigator.pushNamed(context, '/home')
        : Navigator.pushNamed(context, '/login');
  }

  Widget build(BuildContext context) {
    // Timer(Duration(seconds: 5), () => Navigator.pushNamed(context, '/login'));
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
              "Traffic Count Analyzer",
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
