import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:tubes/database/main_data.dart';

class SubsTable {
  // Data Table
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE subscription(
        user_id int,
        kursus_id int
      )
      """);
  }

  // Insert Table
  static Future<int> createSubscription(
      int userId, int kursusId) async {
    final db = await MainDatabase.openDB();

    final data = {
      'user_id': userId,
      'kursus_id': kursusId,
    };
    final id = await db.insert('subscription', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Get Specified Data
  static Future<List<Map<String, dynamic>>> getAllSubscriptionById(
      int userId) async {
    final db = await MainDatabase.openDB();
    return db.query('subscription',
        where: "user_id = ?", whereArgs: [userId]);
  }

  // Get Specified Data
  static Future<List<Map<String, dynamic>>> getSubscriptionById(
      int userId, int kursusId) async {
    final db = await MainDatabase.openDB();
    return db.query('subscription',
        where: "user_id = ? AND kursus_id = ?", whereArgs: [userId,kursusId], limit: 1);
  }

  // Get All Data
  // static Future<List<Map<String, dynamic>>> getItems() async {
  //   final db = await SQLHelper.db();
  //   return db.query('subscription', orderBy: "subscription_id");
  // }

  // // Get Specified Data
  // static Future<List<Map<String, dynamic>>> getItem(
  //     String subscriptionId) async {
  //   final db = await SQLHelper.db();
  //   return db.query('subscription',
  //       where: "subscription_id = ?", whereArgs: [subscriptionId], limit: 1);
  // }

  // // Update Data
  // static Future<int> updateItem(
  //     String subscriptionId, String kursusId, int harga) async {
  //   final db = await SQLHelper.db();

  //   final data = {
  //     'subscription_id': subscriptionId,
  //     'kursus_id': kursusId,
  //     'harga': harga,
  //     'createdAt': DateTime.now().toString()
  //   };

  //   final result = await db.update('subscription', data,
  //       where: "subscription_id = ?", whereArgs: [subscriptionId]);
  //   return result;
  // }

  // // Delete Data
  // static Future<void> deleteItem(String subscriptionId) async {
  //   final db = await SQLHelper.db();
  //   try {
  //     await db.delete("subscription",
  //         where: "subscription_id = ?", whereArgs: [subscriptionId]);
  //   } catch (err) {
  //     debugPrint("Something went wrong when deleting an item: $err");
  //   }
  // }
}
