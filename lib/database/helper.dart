import 'package:app/model/keuangan_model.dart';
import 'package:app/model/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Helper {
  static const int _version = 1;
  static const String _dbName = "Finance.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE User(
          id INTEGER PRIMARY KEY,
          username TEXT NOT NULL,
          password TEXT NOT NULL
        )
      ''');

      await db.execute('''
  CREATE TABLE Finance(
    id INTEGER PRIMARY KEY,
    tanggal TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    jumlah INTEGER NOT NULL,
    keterangan TEXT NOT NULL,
    kategori TEXT NOT NULL
  )
''');
    }, version: _version);
  }

  Future<int> updateUserPassword(User user) async {
    final db = await _getDB();
    return await db.update(
      "User",
      user.toJson(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<User?> getUserByUsername(String username) async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query(
      "User",
      where: 'username = ?',
      whereArgs: [username],
    );
    if (maps.isEmpty) {
      return null;
    }
    return User.fromJson(maps.first);
  }

  static Future<int> addUser(User user) async {
    final db = await _getDB();
    return await db.insert("User", user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<User?> loginUser(String username, String password) async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query(
      "User",
      where: "username = ? AND password = ?",
      whereArgs: [username, password],
    );
    if (maps.isEmpty) {
      return null;
    }
    return User.fromJson(maps[0]);
  }

  static Future<int> addFinance(Keuangan finance) async {
    final db = await _getDB();
    return await db.insert("Finance", finance.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Keuangan>?> getAllFinance() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("Finance");
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => Keuangan.fromJson(maps[index]));
  }
}
