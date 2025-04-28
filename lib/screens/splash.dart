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
    await Future.delayed(Duration(seconds: 1));
    Sharedpreference sp = Sharedpreference();
    String? value = await sp.readCache(key: 'token');

    if (value != null) {
      Navigator.pushReplacement(
        context,
        _createRoute(Dashboard()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        _createRoute(loginpage()),
      );
    }
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

Route _createRoute(screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 0.8);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );

      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
    transitionDuration: Duration(milliseconds: 1000),
  );
}
