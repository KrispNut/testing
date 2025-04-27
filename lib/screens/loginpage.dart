import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:testing/screens/dashboard.dart';
import 'package:testing/services/api_service.dart';
import 'package:testing/services/Sharedpreference.dart';
import 'package:testing/models/loginmodel.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final ApiService _apiService = ApiService();
  Sharedpreference sp = Sharedpreference();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController restaurant_id_Controller = TextEditingController();
  TextEditingController order_resource_id_Controller = TextEditingController();
  TextEditingController device_id_Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF5F5DC),
          image: DecorationImage(
            alignment: Alignment.topCenter,
            matchTextDirection: true,
            fit: BoxFit.cover,
            image: AssetImage("assets/images/wavy_pattern.jpg"),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'Sequel',
                      fontWeight: FontWeight.w600,
                      color: Colors.white70),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailController,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "email...",
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.all(12),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: passwordController,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "password...",
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.all(12),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: restaurant_id_Controller,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Restaurant Id...",
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.all(12),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: order_resource_id_Controller,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Order Resource...",
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.all(12),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: device_id_Controller,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Device Id...",
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.all(12),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                      if (states.contains(WidgetState.pressed)) {
                        return Color(0xFFffb433);
                      }
                      return Color(0xFFfef0ac);
                    }),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    await _apiService.LoginCheck(
                            emailController.text,
                            passwordController.text,
                            int.parse(restaurant_id_Controller.text),
                            int.parse(order_resource_id_Controller.text),
                            device_id_Controller.text)
                        .then((onValue) {
                      final loginResponse =
                          LoginModel.fromJson(jsonDecode(onValue.body));

                      String? token = loginResponse.data?.token;
                      sp.writeCache(key: 'token', value: '$token');
                      // print('Token: $token');
                      if (loginResponse.status == 200) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Dashboard(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Login failed. Please try again.")),
                        );
                      }
                    });
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Sequel',
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
