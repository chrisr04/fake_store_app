import 'package:fake_store_app/core/core.dart';
import 'package:flutter/material.dart';

abstract class FakeNavigator {
  static NavigatorState get root => AppConfig.rootNavigatorKey.currentState!;

  static NavigatorState get menu => AppConfig.menuNavigatorKey.currentState!;
}
