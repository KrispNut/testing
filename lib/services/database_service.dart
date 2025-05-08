import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:testing/models/cartItemsModel.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();
  final StreamController<int> _cartCountController =
      StreamController<int>.broadcast();

  final String _tableName = 'tasks';
  final String _IdColumnName = 'id';
  final String _ContentColumnName = 'content';
  final String _PriceColumnName = 'price';
  final String _AmountColumnName = 'amount';

  DatabaseService._constructor();
  Stream<int> get cartCountStream => _cartCountController.stream;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "testing.db");
    final database = openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE $_tableName(
        $_IdColumnName INTEGER PRIMARY KEY,
        $_ContentColumnName TEXT NOT NULL,
        $_PriceColumnName INTEGER NOT NULL,
        $_AmountColumnName INTEGER NOT NULL
        )
        ''');
      },
    );
    return database;
  }

  Future<int> getInitialCartCount() async {
    final db = await database;
    final result =
        await db.rawQuery('SELECT SUM($_AmountColumnName) FROM $_tableName');
    return result.first.values.first as int? ?? 0;
  }

  Future<void> _updateCartCount() async {
    final db = await database;
    final count =
        await db.rawQuery('SELECT SUM($_AmountColumnName) FROM $_tableName');
    final total = count.first.values.first as int? ?? 0;
    _cartCountController.add(total);
  }

  Future<List<cartItems>?> getItems() async {
    final db = await database;
    final data = await db.query(_tableName);
    List<cartItems> cartitems = data
        .map(
          (e) => cartItems(
            id: e["id"] as int,
            content: e["content"] as String,
            price: (e["price"] as num).toDouble(),
            amount: e["amount"] as int,
          ),
        )
        .toList();
    return cartitems;
  }

  void addItems(String content, double price, int amount) async {
    final db = await database;

    final List<Map<String, dynamic>> existingItems = await db.query(
      _tableName,
      where: '$_ContentColumnName = ? AND $_PriceColumnName = ?',
      whereArgs: [content, price],
    );

    if (existingItems.isNotEmpty) {
      await db.update(
        _tableName,
        {
          _AmountColumnName: existingItems.first[_AmountColumnName] + amount,
        },
        where: '$_ContentColumnName = ? AND $_PriceColumnName = ?',
        whereArgs: [content, price],
      );
    } else {
      await db.insert(_tableName, {
        _ContentColumnName: content,
        _PriceColumnName: price,
        _AmountColumnName: amount,
      });
    }

    await _updateCartCount();
  }

  void removeItem(String content, double price, int amount) async {
    final db = await database;

    final List<Map<String, dynamic>> existingItems = await db.query(
      _tableName,
      where: '$_ContentColumnName = ? AND $_PriceColumnName = ?',
      whereArgs: [content, price],
    );

    if (existingItems.isNotEmpty) {
      int currentAmount = existingItems.first[_AmountColumnName] as int;
      int newAmount = currentAmount - amount;

      if (newAmount > 0) {
        await db.update(
          _tableName,
          {
            _AmountColumnName: newAmount,
          },
          where: '$_ContentColumnName = ? AND $_PriceColumnName = ?',
          whereArgs: [content, price],
        );
      } else {
        await db.delete(
          _tableName,
          where: '$_ContentColumnName = ? AND $_PriceColumnName = ?',
          whereArgs: [content, price],
        );
      }
    }

    await _updateCartCount();
  }

  void deleteItem(String product) async {
    final db = await database;
    await db.rawDelete('DELETE FROM $_tableName WHERE content = ?', [product]);
    await _updateCartCount();
  }

  Future<void> deleteDatabaseFile() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "testing.db");
    await deleteDatabase(databasePath);
    await _updateCartCount();
  }
}
