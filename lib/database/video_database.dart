import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:tubes/database/main_data.dart';

class VideoTable {
  //Data Table
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE video(
        video_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        kursus_id INTEGER,
        judul_video TEXT,
        deskripsi_video TEXT,
        link_video TEXT
      )
      """);
  }

  //Create Table
  // static Future<sql.Database> db() async {
  //   return sql.openDatabase(
  //     'stuwdy.db',
  //     version: 1,
  //     onCreate: (sql.Database database, int version) async {
  //       await createTables(database);
  //     },
  //   );
  // }

  //Insert Table
  static Future<int> createVideo(int kursus_id, String judul_video,
      String? deskripsi_video, String link_video) async {
    final db = await MainDatabase.openDB();

    final data = {
      'kursus_id': kursus_id,
      'judul_video': judul_video,
      'deskripsi_video': deskripsi_video,
      'link_video': link_video
    };
    final id = await db.insert('video', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  //Get All Data
  static Future<List<Map<String, dynamic>>> getVideos() async {
    final db = await MainDatabase.openDB();
    return db.query('video', orderBy: "video_id");
  }

  //Get Video by video_id
  static Future<List<Map<String, dynamic>>> getVideo(int id) async {
    final db = await MainDatabase.openDB();
    return db.query('video', where: "video_id = ?", whereArgs: [id], limit: 1);
  }

  //Get Video by Kursus_id
  static Future<List<Map<String, dynamic>>> getVideoByKursus(int id) async {
    final db = await MainDatabase.openDB();
    return db.query('video', where: "kursus_id = ?", whereArgs: [id]);
  }

  //Update Data
  static Future<int> updateVideo(int id, int kursus_id, String judul_video,
      String? deskripsi_video, String link_video) async {
    final db = await MainDatabase.openDB();

    final data = {
      'kursus_id': kursus_id,
      'judul_video': judul_video,
      'deskripsi_video': deskripsi_video,
      'link_video': link_video
    };

    final result =
        await db.update('video', data, where: "video_id = ?", whereArgs: [id]);
    return result;
  }

  //Delete Data
  static Future<void> deleteVideo(int id) async {
    final db = await MainDatabase.openDB();
    try {
      await db.delete("video", where: "video_id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
