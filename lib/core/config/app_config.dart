import 'package:fake_api/fake_api.dart';
import 'package:flutter/material.dart';

class AppConfig {
  AppConfig._();
  static final AppConfig _instance = AppConfig._();

  factory AppConfig() => _instance;

  static GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> menuNavigatorKey =
      GlobalKey<NavigatorState>();

  late UserEntity _user;

  UserEntity get currentUser => _user;

  void setLoggedUser(UserEntity user) {
    _user = user;
  }
}
