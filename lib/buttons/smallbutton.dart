import 'package:flutter/material.dart';
import 'package:testing/services/database_service.dart';

class Smallbutton extends StatelessWidget {
  final DatabaseService _databaseService = DatabaseService.instance;

  final String? ItemName;
  final String? ItemDescription;
  final String? Price;
  final String? Image;

  Smallbutton({
    super.key,
    required this.ItemName,
    required this.ItemDescription,
    required this.Price,
    required this.Image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 170,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(Image! ?? ' Image not Found'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  ItemName ?? "Unknown Restaurant",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  ItemDescription ?? "Unknown Address",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w200,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rs. $Price' ?? 'Price Unknown',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  IconButton(
                    onPressed: () {
                      double price = double.parse(Price!);
                      if (ItemName == null || ItemName == "") return;
                      _databaseService.addItems(ItemName!, price, 1);
                    },
                    highlightColor: Colors.orangeAccent,
                    icon: Icon(
                      Icons.add,
                      size: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
