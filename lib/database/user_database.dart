import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';
import 'package:tubes/database/main_data.dart';

class User {
  String username;
  String password;
  String email;
  String name;
  String? userImage;

  User({
    required this.username,
    required this.password,
    required this.email,
    required this.name,
    String? userImage,
  }) : userImage = userImage ?? 'assets/images/profile.png';

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'name': name,
      'userImage': userImage
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        username: map['username'],
        password: map['password'],
        email: map['email'],
        name: map['name'],
        userImage: map['userImage']);
  }
}

class UserTable {
  //Data Table
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE users(
          user_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          username TEXT,
          password TEXT,
          email TEXT,
          name TEXT,
          userImage TEXT
        )
        """);
  }

  //Create Table
  // static Future<sql.Database> db() async {
  //   return sql.openDatabase(
  //     'stwudy.db',
  //     version: 1,
  //     onCreate: (sql.Database database, int version) async {
  //       await createTables(database);
  //     },
  //   );
  // }

  // Future<dynamic> alterTable() async {
  //   var dbClient = await UserTable.db();
  //   await dbClient.execute("ALTER TABLE users ADD "
  //       "COLUMN userImage TEXT;");
  // }

  // Future<void> deleteTable() async {
  //   final dbPath = await sql.getDatabasesPath();
  //   final database = await sql.openDatabase(
  //     join(dbPath, 'stwudy.db'),
  //     version: 1,
  //   );

  //   // Execute the DROP TABLE statement to delete the table
  //   await database.execute('DROP TABLE IF EXISTS users;');

  //   await database.close();
  // }

  //Insert Table
  static Future<int> createUser(User user) async {
    // final db = await UserTable.db();
    final db = await MainDatabase.openDB();

    final userId = await db.insert('users', user.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return userId;
  }

  //Get All Data
  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    // final db = await UserTable.db();
    final db = await MainDatabase.openDB();
    return db.query('users', orderBy: "user_id");
  }

  //Get Specified Data
  static Future<List<Map<String, dynamic>>> getUser(int userId) async {
    // final db = await UserTable.db();
    final db = await MainDatabase.openDB();
    return db.query('users',
        where: "user_id = ?", whereArgs: [userId], limit: 1);
  }

  //Update Data
  static Future<int> updateUser(int userId, User user) async {
    // final db = await UserTable.db();
    final db = await MainDatabase.openDB();

    final result = await db.update('users', user.toMap(),
        where: "user_id = ?", whereArgs: [userId]);
    return result;
  }

  //Delete Data
  static Future<void> deleteUser(int userId) async {
    // final db = await UserTable.db();
    final db = await MainDatabase.openDB();
    try {
      await db.delete("users", where: "user_id = ?", whereArgs: [userId]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  Future<List<Map<String, dynamic>>?> login(
      String username, String password) async {
    // final db = await UserTable.db();
    final db = await MainDatabase.openDB();
    final List<Map<String, dynamic>> maps = await db.query(
      "users",
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (maps.isNotEmpty) {
      return maps;
    }
    return null;
  }
}
