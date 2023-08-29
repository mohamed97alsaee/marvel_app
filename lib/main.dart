import 'package:flutter/material.dart';
import 'package:marvel_app/helpers/consts.dart';
import 'package:marvel_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0
        ),
        useMaterial3: false,
      ),
      home: const SplashScreen()
    );
  }
}

