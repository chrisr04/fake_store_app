import 'dart:convert';
import 'package:fake_api/fake_api.dart';
import 'package:flutter/services.dart';

class AppConfig {
  AppConfig._();
  static final AppConfig _instance = AppConfig._();

  factory AppConfig() => _instance;

  // User
  UserEntity? _user;

  UserEntity? get currentUser => _user;

  void setLoggedUser(UserEntity user) {
    _user = user;
  }

  void clearLoggedUser() {
    _user = null;
  }

  // Local assets
  static Map<String, String> strings = {};

  static Map<String, String> images = {};

  static Future<void> initAssets() async {
    strings = await loadStrings();
    images = await loadImages();
  }

  static Future<Map<String, String>> loadStrings() async {
    final encodedStrings = await rootBundle.loadString(
      'assets/values/strings.json',
    );
    return Map<String, String>.from(jsonDecode(encodedStrings));
  }

  static Future<Map<String, String>> loadImages() async {
    final encodedImages = await rootBundle.loadString(
      'assets/values/images.json',
    );
    return Map<String, String>.from(jsonDecode(encodedImages));
  }

  static Future<Map<String, dynamic>> loadSemantics(String path) async {
    final encodedSemantics = await rootBundle.loadString(path);
    return Map<String, dynamic>.from(jsonDecode(encodedSemantics));
  }

  static String getString(String key) => strings[key] ?? '';

  static String getImage(String key) => images[key] ?? '';
}
