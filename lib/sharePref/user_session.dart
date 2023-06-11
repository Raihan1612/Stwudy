import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  static const String _sesId = 'id';
  static const String _sesIdKursus = 'idKursus';
  static const String _sesKategori = 'kat';
  static const String _sesIdVideo = 'idVideo';
  static const String _sesLinkVideo = 'LinkVideo';
  // static const String _sesName = 'name';
  // static const String _sesUsername = 'username';
  // static const String _sesEmail = 'email';
  // static const String _sesPassword = 'password';

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
