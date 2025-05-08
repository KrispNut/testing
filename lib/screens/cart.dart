import 'package:flutter/material.dart';
import 'package:testing/services/database_service.dart';
import 'package:testing/models/cartItemsModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  final DatabaseService _databaseService = DatabaseService.instance;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() {
    final DatabaseService _databaseService = DatabaseService.instance;
    _databaseService.getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 100),
          Text(
            AppLocalizations.of(context)!.cart,
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              fontFamily: 'Sequel',
              color: Colors.black54,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<cartItems>?>(
              future: _databaseService.getItems(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.0, end: 1),
                      duration: const Duration(milliseconds: 1500),
                      builder: (context, value, _) => CircularProgressIndicator(
                        value: 0.70,
                        backgroundColor: Colors.grey,
                        valueColor: AlwaysStoppedAnimation(Colors.orangeAccent),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No items found.'));
                }
                refresh();
                final items = snapshot.data!;

                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];

                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _databaseService.deleteItem(item.content);
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.delete_forever_outlined,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${item.content} (x${item.amount})',
                                    maxLines: 2,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _databaseService.removeItem(
                                        item.content, item.price, 1);
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _databaseService.addItems(
                                        item.content, item.price, 1);
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Rs. ${item.price * item.amount}',
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
