import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/accessibility/accessibility.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/features/cart/cart.dart';
import 'package:fake_store_app/features/catalog/catalog.dart';
import 'package:fake_store_app/features/search/search.dart';
import 'package:fake_store_app/features/auth/auth.dart';
import 'package:fake_store_app/features/home/home.dart';

part 'auth_dependencies.dart';
part 'core_dependencies.dart';
part 'home_dependencies.dart';
part 'catalog_dependencies.dart';
part 'search_dependencies.dart';
part 'cart_dependencies.dart';
part 'menu_dependencies.dart';

class AppDependencies extends StatelessWidget {
  const AppDependencies({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ..._coreDependencies,
        ..._authDependencies,
        ..._homeDepdencencies,
        ..._catalogDependencies,
        ..._searchDependencies,
        ..._cartDependencies,
        ..._menuDepdencencies,
      ],
      child: child,
    );
  }
}
