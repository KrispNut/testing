import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/models/fetchmodel.dart';
import 'package:testing/services/api_service.dart';
import 'package:testing/buttons/smallbutton.dart';
import 'package:testing/buttons/largebutton.dart';
import 'package:testing/screens/loginpage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testing/services/Sharedpreference.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ApiService _apiService = ApiService();

  final double toolbarOpacity = 6.0;

  FetchModel? _restaurantData;
  List<Map<String, String>> _wrapList = [];
  List<Map<String, String>> _burgerList = [];
  List<Map<String, String>> _recommendedList = [];
  List<Map<String, String>> _friezoneList = [];
  List<Map<String, String>> _friedChickenList = [];
  List<Map<String, String>> _sandwichesList = [];
  List<Map<String, String>> _specialitiesList = [];
  List<Map<String, String>> _plattersList = [];

  @override
  void initState() {
    initfetch(1317);
    super.initState();
  }

  Future<void> initfetch(int branchId) async {
    try {
      Sharedpreference sp = Sharedpreference();
      final response = await sp.readCache(key: 'response');
      if (mounted && response != null) {
        final fetchResponse = FetchModel.fromJson(jsonDecode(response));
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
          _friezoneList = _getItemsByCategory("Friezone");

          _friedChickenList = _getItemsByCategory("Fried Chicken");
          _sandwichesList = _getItemsByCategory("Sandwiches");
          _specialitiesList = _getItemsByCategory("Specialities");
          _plattersList = _getItemsByCategory("Platters");
        });
      } else {
        print('Failed to fetch data. Status Code: ${response}');
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
    required bool isCard,
  }) {
    return SizedBox(
      height: isCard ? 250 : 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          final item = itemList[index];

          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: isCard
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
            colors: [const Color(0x00ffffff).withOpacity(0.02), Colors.black12],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              // forceMaterialTransparency: true,
              backgroundColor: Colors.white,
              expandedHeight: 80,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.fromLTRB(10, 1, 1, 1),
                title: Text(
                  AppLocalizations.of(context)!.appTitle,
                  style: TextStyle(
                    fontSize: 45,
                    fontFamily: 'Sequel',
                    fontWeight: FontWeight.w200,
                    color: Colors.black54,
                  ),
                ),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 18, 10, 0),
                  child: IconButton(
                    splashColor: Colors.red,
                    icon: Icon(
                      Icons.login_outlined,
                      size: 32,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => loginpage(),
                        ),
                      );
                      Sharedpreference sp = Sharedpreference();
                      sp.removeCache(key: 'token');
                    },
                  ),
                  // child: CustomDropDownMenu(),
                ),
              ],
              leadingWidth: 300,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                    child: Text(
                      AppLocalizations.of(context)!.categoryName_1,
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sequel',
                          color: Colors.black54),
                    ),
                  ),
                  _buildItemList(
                    itemList: _burgerList,
                    isCard: true,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text(
                      AppLocalizations.of(context)!.categoryName_2,
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sequel',
                          color: Colors.black54),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: _buildItemList(
                      itemList: _wrapList,
                      isCard: false,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text(
                      AppLocalizations.of(context)!.categoryName_3,
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sequel',
                          color: Colors.black54),
                    ),
                  ),
                  _buildItemList(
                    itemList: _recommendedList,
                    isCard: false,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text(
                      AppLocalizations.of(context)!.categoryName_4,
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sequel',
                          color: Colors.black54),
                    ),
                  ),
                  _buildItemList(
                    itemList: _friezoneList,
                    isCard: false,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text(
                      AppLocalizations.of(context)!.categoryName_5,
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sequel',
                          color: Colors.black54),
                    ),
                  ),
                  _buildItemList(
                    itemList: _friedChickenList,
                    isCard: false,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text(
                      AppLocalizations.of(context)!.categoryName_6,
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sequel',
                          color: Colors.black54),
                    ),
                  ),
                  _buildItemList(
                    itemList: _sandwichesList,
                    isCard: false,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text(
                      AppLocalizations.of(context)!.categoryName_7,
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sequel',
                          color: Colors.black54),
                    ),
                  ),
                  _buildItemList(
                    itemList: _specialitiesList,
                    isCard: false,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text(
                      AppLocalizations.of(context)!.categoryName_8,
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sequel',
                          color: Colors.black54),
                    ),
                  ),
                  _buildItemList(
                    itemList: _plattersList,
                    isCard: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
