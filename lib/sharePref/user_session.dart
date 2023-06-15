import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubes/screens/maps/map_screen.dart';

class UserSession {
  static const String _sesId = 'id';
  static const String _sesIdKursus = 'idKursus';
  static const String _sesKategori = 'kat';
  static const String _sesIdVideo = 'idVideo';
  static const String _sesLinkVideo = 'LinkVideo';
  static const String _sesNamaTempat = 'namaTempat';
  static const String _sesAlamatTempat = 'alamatTempat';
  static const String _sesDeskripsiTempat = 'deskripsiTempat';
  static const String _sesLatitude = 'latitude';
  static const String _sesLongitude = 'longitude';

  static Future<void> saveUserData(int data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_sesId, data);
  }

  static Future<void> saveDataKursus(int data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_sesIdKursus, data);
  }

  static Future<void> saveDataVideo(int data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_sesIdVideo, data);
  }

  static Future<void> saveLinkVideo(String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sesLinkVideo, data);
  }

  static Future<void> saveDataKategori(String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sesKategori, data);
  }

  static Future<void> saveDataLokasi(MapContent data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sesNamaTempat, data.namaTempat);
    await prefs.setString(_sesAlamatTempat, data.alamatTempat);
    await prefs.setString(_sesDeskripsiTempat, data.deskripsiTempat);
    await prefs.setDouble(_sesLatitude, data.latitude);
    await prefs.setDouble(_sesLongitude, data.longitude);
  }

  static Future<int?> getId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_sesId);
  }

  static Future<int?> getKursus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_sesIdKursus);
  }

  static Future<String?> getLinkVideo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_sesLinkVideo);
  }

  static Future<int?> getVideoId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_sesIdVideo);
  }

  static Future<String?> getKategori() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_sesKategori);
  }

  static Future<Map<String, dynamic>> getDataLokasi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String nama = prefs.getString(_sesNamaTempat) ?? '';
    final String alamat = prefs.getString(_sesAlamatTempat) ?? '';
    final String deskripsi = prefs.getString(_sesDeskripsiTempat) ?? '';
    final double latitude = prefs.getDouble(_sesLatitude) ?? 0.0;
    final double longitude = prefs.getDouble(_sesLongitude) ?? 0.0;

    final Map<String, dynamic> data = {
      'nama': nama,
      'alamat': alamat,
      'deskripsi': deskripsi,
      'latitude': latitude,
      'longitude': longitude,
    };

    return data;
  }

  static Future<void> clearLokasi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sesNamaTempat);
    await prefs.remove(_sesAlamatTempat);
    await prefs.remove(_sesDeskripsiTempat);
    await prefs.remove(_sesLatitude);
    await prefs.remove(_sesLongitude);
  }

  static Future<void> clearUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sesId);
    await prefs.remove(_sesIdKursus);
    await prefs.remove(_sesKategori);
  }

  static Future<void> clearKategori() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sesKategori);
  }
}
