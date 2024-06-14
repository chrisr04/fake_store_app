import 'package:fake_store_app/core/core.dart';
import 'package:flutter/material.dart';

class FakeNavigator {
  FakeNavigator._();

  static NavigatorState get root => AppConfig.rootNavigatorKey.currentState!;

  static NavigatorState get menu => AppConfig.menuNavigatorKey.currentState!;
}
