// my_database.dart
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';
import 'package:tubes/database/kursus_database.dart';
import 'package:tubes/database/user_database.dart';
import 'package:tubes/database/video_database.dart';

class MainDatabase {
  static Future<sql.Database> openDB() async {
    final dbPath = await sql.getDatabasesPath();
    final path = join(dbPath, 'stuwdy.db');

    return sql.openDatabase(path, version: 1, onCreate: (db, version) async {
      await UserTable.createTables(db);
      await KursusTable.createTables(db);
      await VideoTable.createTables(db);
      // Create other tables here
    });
  }
}
