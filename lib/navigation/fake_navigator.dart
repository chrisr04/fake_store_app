import 'package:flutter/material.dart';

abstract class FakeNavigator {
  static GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> menuNavigatorKey =
      GlobalKey<NavigatorState>();

  static NavigatorState get root => rootNavigatorKey.currentState!;

  static NavigatorState get menu => menuNavigatorKey.currentState!;
}
