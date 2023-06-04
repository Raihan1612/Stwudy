// import 'package:flutter/cupertino.dart';
// import 'package:sqflite/sqflite.dart' as sql;

// class SQLHelper {
//   // Data Table
//   static Future<void> createTables(sql.Database database) async {
//     await database.execute("""CREATE TABLE items(
//         subscription_id TEXT PRIMARY KEY,
//         kursus_id TEXT REFERENCES Kursus(kursus_id),
//         harga INTEGER,
//         createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
//       )
//       """);
//   }

//   // Create Table
//   static Future<sql.Database> db() async {
//     return sql.openDatabase(
//       'test.db',
//       version: 1,
//       onCreate: (sql.Database database, int version) async {
//         await createTables(database);
//       },
//     );
//   }

//   // Insert Table
//   static Future<int> createItem(
//       String subscriptionId, String kursusId, int harga) async {
//     final db = await SQLHelper.db();

//     final data = {
//       'subscription_id': subscriptionId,
//       'kursus_id': kursusId,
//       'harga': harga
//     };
//     final id = await db.insert('items', data,
//         conflictAlgorithm: sql.ConflictAlgorithm.replace);
//     return id;
//   }

//   // Get All Data
//   static Future<List<Map<String, dynamic>>> getItems() async {
//     final db = await SQLHelper.db();
//     return db.query('items', orderBy: "subscription_id");
//   }

//   // Get Specified Data
//   static Future<List<Map<String, dynamic>>> getItem(
//       String subscriptionId) async {
//     final db = await SQLHelper.db();
//     return db.query('items',
//         where: "subscription_id = ?", whereArgs: [subscriptionId], limit: 1);
//   }

//   // Update Data
//   static Future<int> updateItem(
//       String subscriptionId, String kursusId, int harga) async {
//     final db = await SQLHelper.db();

//     final data = {
//       'subscription_id': subscriptionId,
//       'kursus_id': kursusId,
//       'harga': harga,
//       'createdAt': DateTime.now().toString()
//     };

//     final result = await db.update('items', data,
//         where: "subscription_id = ?", whereArgs: [subscriptionId]);
//     return result;
//   }

//   // Delete Data
//   static Future<void> deleteItem(String subscriptionId) async {
//     final db = await SQLHelper.db();
//     try {
//       await db.delete("items",
//           where: "subscription_id = ?", whereArgs: [subscriptionId]);
//     } catch (err) {
//       debugPrint("Something went wrong when deleting an item: $err");
//     }
//   }
// }
