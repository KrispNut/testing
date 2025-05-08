import 'package:flutter/material.dart';
import 'package:testing/screens/profile.dart';
import 'package:testing/screens/cart.dart';
import 'package:testing/screens/dashboard.dart';
import '../services/database_service.dart';

class Navigationpage extends StatefulWidget {
  Navigationpage({super.key});

  @override
  State<Navigationpage> createState() => _NavigationpageState();
}

final DatabaseService _databaseService = DatabaseService.instance;

int currentPageIndex = 0;
final List<Widget> pages = [
  Dashboard(),
  ShoppingCart(),
  ProfilePage(),
];

class _NavigationpageState extends State<Navigationpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPageIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStatePropertyAll(
            const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
        child: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          backgroundColor: Colors.black,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: currentPageIndex,
          indicatorColor: Colors.white,
          elevation: 20,
          destinations: [
            NavigationDestination(
              label: 'Home',
              icon: Icon(Icons.home),
              selectedIcon: Icon(Icons.home),
            ),
            NavigationDestination(
              label: 'Cart',
              icon: FutureBuilder<int>(
                future: _databaseService.getInitialCartCount(),
                builder: (context, futureSnapshot) {
                  if (futureSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Icon(Icons.shopping_cart);
                  }

                  final initialCount = futureSnapshot.data ?? 0;

                  return StreamBuilder<int?>(
                    stream: _databaseService.cartCountStream,
                    initialData: initialCount,
                    builder: (context, streamSnapshot) {
                      final count = streamSnapshot.data ?? 0;
                      if (count > 0) {
                        return Badge.count(
                          count: count,
                          child: const Icon(Icons.shopping_cart),
                        );
                      } else {
                        return const Icon(Icons.shopping_cart);
                      }
                    },
                  );
                },
              ),
            ),
            NavigationDestination(
              label: 'Profile',
              icon: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
