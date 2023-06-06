import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:tubes/database/main_data.dart';

class KursusTable {
  //Data Table
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE kursus(
        kursus_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        judul_kursus TEXT,
        kategori TEXT,
        deskripsi_kursus TEXT,
        jumlah_video INT,
        kursusImage TEXT
        )
      """);
  }

  //Create Table
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'stwudy.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  //Insert Table
  static Future<int> createKursus(String judul_kursus, kategori,
      String? deskripsi_kursus, String kursusImage) async {
    // final db = await kursusTable.db();
    final db = await MainDatabase.openDB();

    final data = {
      'judul_kursus': judul_kursus,
      'kategori': kategori,
      'deskripsi_kursus': deskripsi_kursus,
      'jumlah_video': 0,
      'kursusImage': kursusImage
    };
    final id = await db.insert('kursus', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  //Get All Data
  static Future<List<Map<String, dynamic>>> getAllKursus() async {
    // final db = await kursusTable.db();
    final db = await MainDatabase.openDB();
    return db.query('kursus', orderBy: "kursus_id");
  }

  //Get Specified Data
  static Future<List<Map<String, dynamic>>> getKursus(int id) async {
    // final db = await kursusTable.db();
    final db = await MainDatabase.openDB();
    return db.query('kursus',
        where: "kursus_id = ?", whereArgs: [id], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> getKursusbyKat(String kat) async {
    // final db = await kursusTable.db();
    final db = await MainDatabase.openDB();
    return db.query('kursus',
        where: "kategori = ?", whereArgs: [kat]);
  }

  //Update Data
  static Future<int> updateKursus(int id, String judul_kursus, kategori,
      String? deskripsi_kursus, String jumlah_video, String kursusImage) async {
    // final db = await kursusTable.db();
    final db = await MainDatabase.openDB();

    final data = {
      'judul_kursus': judul_kursus,
      'kategori': kategori,
      'deskripsi_kursus': deskripsi_kursus,
      'jumlah_video': int.tryParse(jumlah_video) ?? 0,
      'kursusImage': kursusImage
    };

    final result = await db
        .update('kursus', data, where: "kursus_id = ?", whereArgs: [id]);
    return result;
  }

  //Delete Data
  static Future<void> deleteKursus(int id) async {
    // final db = await kursusTable.db();
    final db = await MainDatabase.openDB();
    try {
      await db.delete("kursus", where: "kursus_id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
