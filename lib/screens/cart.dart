import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/screens/dashboard.dart';
import 'package:testing/models/cartItemsModel.dart';
import 'package:testing/services/database_service.dart';

class ShoppingCart extends StatelessWidget {
  final DatabaseService _databaseService = DatabaseService.instance;
  ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 100),
          Text(
            'Shopping Cart',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              fontFamily: 'Sequel',
              color: Colors.black54,
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: _databaseService.getTasks(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      cartItems cartitems = snapshot.data![index];
                      return ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${cartitems.content}'),
                            Text('${cartitems.amount}'),
                          ],
                        ),
                      );
                    },
                  );
                }),
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
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
