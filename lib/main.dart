import 'package:flutter/material.dart';
import 'package:perhitungan_persimpangan/screen/home_screen.dart';
import 'package:perhitungan_persimpangan/screen/hv_screen.dart';
import 'package:perhitungan_persimpangan/screen/lv_screen.dart';
import 'package:perhitungan_persimpangan/screen/splash_screen.dart';

import 'api/sheets/sheets_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SheetsApi.init();

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
      },
    );
  }
}