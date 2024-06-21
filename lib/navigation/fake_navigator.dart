import 'package:flutter/material.dart';

abstract class FakeNavigator {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static final menuNavigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState get root => rootNavigatorKey.currentState!;

  static NavigatorState get menu => menuNavigatorKey.currentState!;
}
