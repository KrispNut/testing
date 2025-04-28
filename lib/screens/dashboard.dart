import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testing/models/fetchmodel.dart';
import 'package:testing/services/Sharedpreference.dart';
import 'package:testing/services/api_service.dart';
import 'package:testing/screens/loginpage.dart';
import 'package:testing/buttons/smallbutton.dart';
import 'package:testing/buttons/largebutton.dart';
import 'package:testing/buttons/dropdown.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ApiService _apiService = ApiService();

  final double toolbarOpacity = 2.0;
  int current_index = 0;

  void onTap(int index) {
    setState(() {
      current_index = index;
    });
  }

  @override
  void initState() {
    initfetch();
    super.initState();
  }

  initfetch() async {
    await _apiService.fetchData(1236).then((onValue) {
      final fetchResponse = FetchModel.fromJson(jsonDecode(onValue.body));

      String? restaurantName = fetchResponse.data?.name;
      String? restaurantAddress = fetchResponse.data?.address;
      String? logoUrl = fetchResponse.data?.logoUrl;
      String? phoneNumber = fetchResponse.data?.phoneNumber;
      String? closingTime = fetchResponse.data?.closeTime;
      if (!mounted) return;
      setState(() {
        _fetchedRestaurantName = restaurantName;
        _fetchedRestaurantAddress = restaurantAddress;
        _fetchedLogoUrl = logoUrl;
        _fetchedphoneNumber = phoneNumber;
        _closingTime = closingTime;
      });
    });
  }

  String? _fetchedRestaurantName;
  String? _fetchedRestaurantAddress;
  String? _fetchedLogoUrl;
  String? _fetchedphoneNumber;
  String? _closingTime;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final TextEditingController _searchController = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xFF282a57).withOpacity(0.5), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              stretch: true,
              pinned: true,
              floating: false,
              forceMaterialTransparency: true,
              expandedHeight: 80,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.all(0),
                title: Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Foodie',
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'Crude',
                      fontWeight: FontWeight.w200,
                      color: Colors.blueGrey.shade700,
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 18, 10, 0),
                  child: CustomDropDownMenu(),
                ),
              ],
              leadingWidth: 300,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 30),
                  Largebutton(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text(
                      'Your trusted picks',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sequel',
                          color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Smallbutton(
                            RestaurantName: _fetchedRestaurantName,
                            RestaurantAddress: _fetchedRestaurantAddress,
                            PhoneNumber: _fetchedphoneNumber,
                            ClosingTime: _closingTime,
                            Image: _fetchedLogoUrl,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Smallbutton(
                            RestaurantName: _fetchedRestaurantName,
                            RestaurantAddress: _fetchedRestaurantAddress,
                            PhoneNumber: _fetchedphoneNumber,
                            ClosingTime: _closingTime,
                            Image: _fetchedLogoUrl,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                    child: Text(
                      'Recommended',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sequel',
                          color: Colors.grey),
                    ),
                  ),
                  Largebutton(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: current_index,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Navigate',
            icon: Icon(Icons.card_travel_sharp),
          ),
          BottomNavigationBarItem(
            label: 'Like',
            icon: Icon(Icons.heart_broken_rounded),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
