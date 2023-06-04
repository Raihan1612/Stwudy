import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  static const String _sesId = 'id';
  static const String _sesIdKursus = 'idKursus';
  // static const String _sesName = 'name';
  // static const String _sesUsername = 'username';
  // static const String _sesEmail = 'email';
  // static const String _sesPassword = 'password';

  static Future<void> saveUserData(int data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_sesId, data);
    // await prefs.setString(_sesName, data['name'].toString());
    // await prefs.setString(_sesUsername, data['username'].toString());
    // await prefs.setString(_sesEmail, data['email'].toString());
    // await prefs.setString(_sesPassword, data['password'].toString());
  }

  static Future<void> saveDataKursus(int data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_sesIdKursus, data);
  }

  static Future<int?> getId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_sesId);
  }

  static Future<int?> getKursus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_sesIdKursus);
  }

  // static Future<String?> getName() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_sesName);
  // }

  // static Future<String?> getUsername() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_sesUsername);
  // }

  // static Future<String?> getEmail() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_sesEmail);
  // }

  // static Future<String?> getPassword() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_sesPassword);
  // }

  static Future<void> clearUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sesId);
    await prefs.remove(_sesIdKursus);
    // await prefs.remove(_sesName);
    // await prefs.remove(_sesUsername);
    // await prefs.remove(_sesEmail);
    // await prefs.remove(_sesPassword);
  }
}
