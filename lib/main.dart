import 'package:flutter/material.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:fake_store_app/navigation/navigation.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      child: MaterialApp(
        theme: FakeTheme.light,
        navigatorKey: AppConfig.rootNavigatorKey,
        initialRoute: AppRoutes.welcome,
        onGenerateRoute: RouteGenerator.onGenerateRoute,
      ),
    );
  }
}
