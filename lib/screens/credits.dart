import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/screens/dashboard.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Credits',
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sequel',
                  color: Colors.black54),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Dashboard(),
                  ),
                );
              },
              child: Text('Go Back'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80),
                ),
                backgroundColor: Colors.black54,
                foregroundColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
