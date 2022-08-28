import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:perhitungan_persimpangan/screen/access_code_screen.dart';
import 'package:perhitungan_persimpangan/screen/home_screen.dart';
import 'package:perhitungan_persimpangan/screen/hv_screen.dart';
import 'package:perhitungan_persimpangan/screen/login_screen.dart';
import 'package:perhitungan_persimpangan/screen/lv_screen.dart';
import 'package:perhitungan_persimpangan/screen/signUp_screen.dart';
import 'package:perhitungan_persimpangan/screen/splash_screen.dart';

import 'api/sheets/sheets_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SheetsApi.init();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/access-code': (context) => AccessCodeScreen(),
        '/sign-up': (context) => SignUpScreen(),
      },
    );
  }
}
