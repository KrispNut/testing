import 'package:flutter/material.dart';

class Smallbutton extends StatelessWidget {
  final String? RestaurantName;
  final String? RestaurantAddress;
  final String? PhoneNumber;
  final String? ClosingTime;
  final String? Image;

  const Smallbutton({
    super.key,
    required this.RestaurantName,
    required this.RestaurantAddress,
    required this.PhoneNumber,
    required this.ClosingTime,
    required this.Image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 170,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey, Colors.blueGrey.shade500],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
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
                image: AssetImage('assets/images/image_2.png'),
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
                  RestaurantName ?? "Unknown Restaurant",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  RestaurantAddress ?? "Unknown Address",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  PhoneNumber ?? "Unknown Number",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
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
                    'Closes at $ClosingTime' ?? 'Closing Unknown',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 15,
                    child: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.add,
                        size: 16,
                        color: Colors.black,
                      ),
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
