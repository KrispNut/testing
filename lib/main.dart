import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/screens/loginpage.dart';
import 'package:testing/screens/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

// jwt tokens / bearer token authorization
// model classes json to dart
// session shared preference
