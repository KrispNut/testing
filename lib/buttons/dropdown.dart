import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:testing/services/Sharedpreference.dart';

import '../main.dart';

class CustomDropDownMenu extends StatefulWidget {
  const CustomDropDownMenu({Key? key}) : super(key: key);

  @override
  State<CustomDropDownMenu> createState() => _CustomDropdownMenuState();
}

Sharedpreference sp = Sharedpreference();

class _CustomDropdownMenuState extends State<CustomDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          customButton: const Icon(
            Icons.arrow_drop_down_rounded,
            size: 32,
            color: Colors.grey,
          ),
          items: MenuItems.languageList
              .map(
                (item) => DropdownMenuItem<MenuItem>(
                  value: item,
                  child: MenuItems.buildItem(item),
                ),
              )
              .toList(),
          onChanged: (value) {
            final selected = value as MenuItem;

            switch (selected.text) {
              case 'English':
                sp.writeCache(key: 'language', value: 'en');
                main();
                break;
              case 'French':
                sp.writeCache(key: 'language', value: 'fr');
                main();
                break;
              case 'Arabic':
                sp.writeCache(key: 'language', value: 'ar');
                main();
                break;
              case 'Spanish':
                sp.writeCache(key: 'language', value: 'es');
                main();
                break;
              case 'Urdu':
                sp.writeCache(key: 'language', value: 'ur');
                main();
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
            customHeights:
                List<double>.filled(MenuItems.languageList.length, 48),
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem(this.text, [this.icon = Icons.language]);
}

class MenuItems {
  static const List<MenuItem> languageList = [
    MenuItem('English'),
    MenuItem('French'),
    MenuItem('Arabic'),
    MenuItem('Spanish'),
    MenuItem('Urdu'),
  ];

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(width: 10),
        Text(
          item.text,
          style: const TextStyle(color: Colors.white, fontFamily: "Sequel"),
        ),
      ],
    );
  }
}
