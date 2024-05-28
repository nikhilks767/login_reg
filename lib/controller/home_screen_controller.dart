import 'package:login_reg/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:developer';

class SQLDatabase {
  static Future<Database> initializeDb() async {
    final databasepath = await getDatabasesPath();
    String path = join(databasepath, 'myData.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE user(id INTEGER PRIMARY KEY, name TEXT, email TEXT, phone INTEGER, pass TEXT)');
    });
  }

//Login
  static Future<Users?> login(Users user) async {
    final db = await initializeDb();
    var result = await db.rawQuery(
        "SELECT * FROM user WHERE email = '${user.email}' AND pass = '${user.pass}'");
    log("Login query result: $result");
    if (result.isNotEmpty) {
      return Users.fromMap(result.first);
    } else {
      return null;
    }
  }

//Register
  static Future<int> register(Users user) async {
    final db = await initializeDb();
    if (user.name.isEmpty ||
        user.email.isEmpty ||
        user.phone == 0 ||
        user.pass.isEmpty) {
      throw ArgumentError('All fields must be filled');
    }
    try {
      return await db.insert('user', user.toMap());
    } catch (e) {
      // Handle exceptions such as uniqueness constraints violation
      print("Error: $e");
      return -1; // Indicate an error
    }
  }

//Get All User List
  static Future<List<Users>> getAllUsers() async {
    final db = await initializeDb();
    final List<Map<String, dynamic>> result = await db.query('user');

    return result.map((map) => Users.fromMap(map)).toList();
  }

//Check if an email already exists
  static Future<bool> emailExists(String email) async {
    final db = await initializeDb();
    final List<Map<String, dynamic>> result = await db.query(
      'user',
      where: 'email=?',
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }
}
