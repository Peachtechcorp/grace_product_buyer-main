import 'dart:io';
import 'package:grace_product_buyer/app/models/cart.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// database table and column names
const String tableCarts = 'carts';
const String columnId = 'id';
const String productId = 'product_id';
const String quantity = 'quantity';

class DatabaseHelper {
  static const _databaseName = 'Mydatabase.db';
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);

    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE $tableCarts (
    $columnId INTEGER PRIMARY KEY,
    $productId INTEGER NOT NULL,
    $quantity INTEGER NOT NULL,
  )
''');
  }

  Future<int> insert(Cart cart) async {
    Database db = await database;
    int id = await db.insert(tableCarts, cart.toMap());
    return id;
  }
}
