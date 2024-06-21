import 'dart:convert';

import 'package:fake_api/fake_api.dart';
import 'package:flutter/services.dart';

class AppConfig {
  AppConfig._();
  static final AppConfig _instance = AppConfig._();

  factory AppConfig() => _instance;

  UserEntity? _user;
  static Map<String, String> _strings = {};
  static Map<String, String> _images = {};

  UserEntity? get currentUser => _user;

  static Future<void> init() async {
    final encodedStrings = await rootBundle.loadString(
      'assets/values/strings.json',
    );
    final ecodedImages = await rootBundle.loadString(
      'assets/values/images.json',
    );
    _strings = Map<String, String>.from(jsonDecode(encodedStrings));
    _images = Map<String, String>.from(jsonDecode(ecodedImages));
  }

  static String getString(String key) => _strings[key] ?? '';

  static String getImage(String key) => _images[key] ?? '';

  void setLoggedUser(UserEntity user) {
    _user = user;
  }
}
