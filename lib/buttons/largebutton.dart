import 'package:flutter/material.dart';
import 'package:testing/services/database_service.dart';

class Largebutton extends StatelessWidget {
  final DatabaseService _databaseService = DatabaseService.instance;

  final String? DealName;
  final String? ItemDescription;
  final String? Price;
  final String? Image;

  Largebutton({
    super.key,
    required this.DealName,
    required this.ItemDescription,
    required this.Price,
    required this.Image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).size.height * 0.77,
      width: MediaQuery.of(context).size.width - 20,
      decoration: BoxDecoration(
        color: Colors.white,
        // gradient: LinearGradient(
        //   colors: [const Color(0xFFa7b0a9).withOpacity(0.7), Colors.blueGrey],
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        // ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: DealName! ?? 'text not found',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                      children: <InlineSpan>[
                        TextSpan(
                          text: '\n${ItemDescription! ?? 'text not found'}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  IconButton(
                    highlightColor: Colors.orangeAccent,
                    icon: Icon(
                      Icons.shopping_cart,
                      size: 32,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      double price = double.parse(Price!);
                      if (DealName == null || DealName == "") return;
                      _databaseService.addItems(DealName!, price, 1);
                    },
                  ),
                  Text("Rs. $Price" ?? 'Price')
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(Image! ?? ' Image not Found'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
