import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:tubes/database/main_data.dart';

class WishlistTable {
  // Data Table
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE wishlist(
        user_id int,
        kursus_id int
      )
      """);
  }

  // Insert Table
  static Future<int> createWishlist(
      int userId, int kursusId) async {
    final db = await MainDatabase.openDB();

    final data = {
      'user_id': userId,
      'kursus_id': kursusId,
    };
    final id = await db.insert('wishlist', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Get Specified Data
  static Future<List<Map<String, dynamic>>> getAllWishlistById(
      int userId) async {
    final db = await MainDatabase.openDB();
    return db.query('wishlist',
        where: "user_id = ?", whereArgs: [userId]);
  }

  // Get Specified Data
  static Future<List<Map<String, dynamic>>> getWishlistById(
      int userId, int kursusId) async {
    final db = await MainDatabase.openDB();
    return db.query('wishlist',
        where: "user_id = ? AND kursus_id = ?", whereArgs: [userId,kursusId], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> getKursusWish(int userId) async {
  final db = await MainDatabase.openDB();
  
  // Construct the SQL query with the join clause and WHERE clause
  final query = '''
    SELECT *
    FROM kursus
    INNER JOIN wishlist ON kursus.kursus_id = wishlist.kursus_id
    WHERE wishlist.user_id = ?
  ''';
  
  // Execute the query with the parameter value
  final results = await db.rawQuery(query, [userId]);
  
  return results;
}

  // Delete Data
  static Future<void> deleteWishlist(int userId, int kursusId) async {
    final db = await MainDatabase.openDB();
    try {
      await db.delete("wishlist",
          where: "user_id = ? AND kursus_id = ?", whereArgs: [userId,kursusId]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}