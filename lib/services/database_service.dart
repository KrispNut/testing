import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:testing/models/cartItemsModel.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();
  final String _tableName = 'tasks';
  final String _IdColumnName = 'id';
  final String _ContentColumnName = 'content';
  final String _AmountColumnName = 'amount';

  DatabaseService._constructor();

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
        $_AmountColumnName INTEGER NOT NULL
        )
        ''');
      },
    );
    return database;
  }

  void addTask(String content, double amount) async {
    final db = await database;
    await db.insert(_tableName, {
      _ContentColumnName: content,
      _AmountColumnName: amount,
    });
  }

  Future<List<cartItems>?> getTasks() async {
    final db = await database;
    final data = await db.query(_tableName);
    List<cartItems> cartitems = data
        .map((e) => cartItems(
            id: e["id"] as int,
            content: e["content"] as String,
            amount: (e["amount"] as num).toDouble()))
        .toList();
    print(cartitems);
    return cartitems;
  }

  Future<void> deleteDatabaseFile() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "testing.db");
    await deleteDatabase(databasePath);
  }
}
