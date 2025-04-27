import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/screens/dashboard.dart';
import 'package:testing/screens/loginpage.dart';
import 'package:testing/services/Sharedpreference.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool boolTrue = false;

  @override
  void initState() {
    initSplash();
    super.initState();
  }

  initSplash() async {
    Sharedpreference sp = Sharedpreference();
    String? value = await sp.readCache(key: 'token');

    Future.delayed(const Duration(seconds: 5), () {
      if (value != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Dashboard()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => loginpage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: boolTrue ? AppBar() : null,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xFF282a57).withOpacity(0.5), Colors.black],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                width: 250,
                height: 250,
                image: AssetImage('assets/images/Logo.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
