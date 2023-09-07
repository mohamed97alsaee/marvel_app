import 'package:marvel_app/screens/auth_screens/login_screen.dart';
import 'package:marvel_app/screens/auth_screens/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:marvel_app/helpers/consts.dart';
import 'package:marvel_app/providers/auth_provider.dart';
import 'package:marvel_app/providers/movies_provider.dart';
import 'package:marvel_app/screens/main_screens/home_screen.dart';

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
        ChangeNotifierProvider<MoviesProvider>(
            create: (context) => MoviesProvider()),
        ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
            appBarTheme:
                const AppBarTheme(backgroundColor: Colors.white, elevation: 0),
            useMaterial3: false,
          ),
          home: const SplashScreen() //const ScreenRouter()
          ),
    );
  }
}

class ScreenRouter extends StatefulWidget {
  const ScreenRouter({super.key});

  @override
  State<ScreenRouter> createState() => _ScreenRouterState();
}

class _ScreenRouterState extends State<ScreenRouter> {
  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).initAuthProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authConsumer, child) {
        return authConsumer.authenticated
            ? const HomeScreen()
            : const LoginScreen();
      },
    );
  }
}
