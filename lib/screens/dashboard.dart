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

  final double toolbarOpacity = 6.0;
  int current_index = 0;

  void onTap(int index) {
    setState(() {
      current_index = index;
    });
  }

  FetchModel? _restaurantData;
  List<Map<String, String>> _wrapList = [];
  List<Map<String, String>> _burgerList = [];
  List<Map<String, String>> _recommendedList = [];

  List<String> smallCardImagePaths = [
    'assets/images/pizza.png',
    'assets/images/chinese.png',
    'assets/images/kfc.png',
  ];
  List<String> largeCardImagePaths = [
    'assets/images/sushi.png',
    'assets/images/korean_bbq.png',
    'assets/images/brim.png',
  ];

  @override
  void initState() {
    initfetch(1317);
    super.initState();
  }

  Future<void> initfetch(int branchId) async {
    try {
      final response = await _apiService.fetchData(branchId);
      if (response.statusCode == 200) {
        final fetchResponse = FetchModel.fromJson(jsonDecode(response.body));
        setState(() {
          _restaurantData = fetchResponse;
          _fetchedRestaurantName = fetchResponse.data?.name;
          _fetchedRestaurantAddress = fetchResponse.data?.address;
          _fetchedLogoUrl = fetchResponse.data?.logoUrl;
          _fetchedphoneNumber = fetchResponse.data?.phoneNumber;
          _closingTime = fetchResponse.data?.closeTime;
          _burgerList = _getItemsByCategory("Deals");
          _wrapList = _getItemsByCategory("Fried Chicken");
          _recommendedList = _getItemsByCategory("Burgers");
        });
      } else {
        print('Failed to fetch data. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  List<Map<String, String>> _getItemsByCategory(String categoryName) {
    List<Map<String, String>> items = [];
    if (_restaurantData?.data?.restaurantBranchMenu != null) {
      for (var category in _restaurantData!.data!.restaurantBranchMenu) {
        if (category.name == categoryName && category.menu.isNotEmpty) {
          for (var menuItem in category.menu) {
            items.add({
              'name': menuItem.name ?? 'N/A',
              'price': menuItem.price ?? 'N/A',
              'description': menuItem.description ?? '',
              'image_url': menuItem.imageUrl ?? '',
            });
          }
        }
      }
    }
    return items;
  }

  String? _fetchedRestaurantName;
  String? _fetchedRestaurantAddress;
  String? _fetchedLogoUrl;
  String? _fetchedphoneNumber;
  String? _closingTime;

  Widget _buildItemList({
    required List<Map<String, String>> itemList,
    required List<String> imagePathList,
    required bool isLarge,
  }) {
    return SizedBox(
      height: isLarge ? 250 : 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          final item = itemList[index];
          final imageIndex = index % imagePathList.length;
          final imagePath = imagePathList[imageIndex];

          if (imagePath == null) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: isLarge ? 170 : 150,
                height: isLarge ? 200 : 180,
                color: Colors.grey.shade300,
                child: Center(child: Text('Image not found')),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: isLarge
                ? Largebutton(
                    DealName: item['name']!,
                    ItemDescription: item['description']!,
                    Price: item['price'],
                    Image: item['image_url'],
                  )
                : Smallbutton(
                    ItemName: item['name']!,
                    ItemDescription: item['description']!,
                    Price: item['price'],
                    Image: item['image_url'],
                  ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              backgroundColor: Colors.black,
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
                  _buildItemList(
                    itemList: _burgerList,
                    imagePathList: largeCardImagePaths,
                    isLarge: true,
                  ),
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
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: _buildItemList(
                      itemList: _wrapList,
                      imagePathList: smallCardImagePaths,
                      isLarge: false,
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
                  _buildItemList(
                    itemList: _recommendedList,
                    imagePathList: largeCardImagePaths,
                    isLarge: true,
                  ),
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
