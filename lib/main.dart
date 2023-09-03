import 'package:flutter/material.dart';
import 'package:marvel_app/helpers/consts.dart';
import 'package:marvel_app/providers/movies_provider.dart';
import 'package:marvel_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MoviesProvider>(create: (context)=> MoviesProvider())
      ],
      child: MaterialApp(
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
      ),
    );
  }
}

