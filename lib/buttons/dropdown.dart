import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:testing/screens/cart.dart';
import 'package:testing/screens/loginpage.dart';
import 'package:testing/screens/dashboard.dart';
import 'package:testing/screens/credits.dart';
import 'package:testing/services/Sharedpreference.dart';

class CustomDropDownMenu extends StatefulWidget {
  const CustomDropDownMenu({Key? key}) : super(key: key);

  @override
  State<CustomDropDownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: const Icon(
          Icons.settings,
          size: 32,
          color: Colors.blueGrey,
        ),
        items: [
          ...MenuItems.firstItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
          const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
          ...MenuItems.secondItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
        ],
        onChanged: (value) async {
          MenuItem selectedItem = value as MenuItem;
          switch (selectedItem) {
            case MenuItems.cart:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoppingCart(),
                ),
              );
              break;
            case MenuItems.logout:
              Sharedpreference sp = Sharedpreference();
              sp.removeCache(key: 'token');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => loginpage()),
              );
              break;
          }
        },
        dropdownStyleData: DropdownStyleData(
          width: 200,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent.withOpacity(0.3),
          ),
          offset: const Offset(0, 8),
        ),
        menuItemStyleData: MenuItemStyleData(
          customHeights: [
            ...List<double>.filled(MenuItems.firstItems.length, 48),
            8,
            ...List<double>.filled(MenuItems.secondItems.length, 48),
          ],
          padding: const EdgeInsets.only(left: 16, right: 16),
        ),
      ),
    );
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  static const List<MenuItem> firstItems = [cart];
  static const List<MenuItem> secondItems = [logout];

  static const cart = MenuItem(text: 'Cart', icon: Icons.description_outlined);
  static const logout = MenuItem(text: 'Log Out', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(color: Colors.white, fontFamily: "Sequel"),
          ),
        ),
      ],
    );
  }
}
