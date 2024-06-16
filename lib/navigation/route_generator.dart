import 'package:flutter/material.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/navigation/navigation.dart';
import 'package:fake_store_app/features/auth/auth.dart';
import 'package:fake_store_app/features/menu/menu.dart';
import 'package:fake_store_app/features/home/home.dart';
import 'package:fake_store_app/features/catalog/catalog.dart';
import 'package:fake_store_app/features/search/search.dart';
import 'package:fake_store_app/features/support/support.dart';
import 'package:fake_store_app/features/cart/cart.dart';

class RouteGenerator {
  static PageRoute<dynamic> onGenerateRoute(RouteSettings settings) =>
      MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => switch (settings.name) {
          AppRoutes.welcome => const WelcomePage(),
          AppRoutes.login => const LoginPage(),
          AppRoutes.register => const RegisterPage(),
          AppRoutes.menu => const MenuPage(),
          _ => const NotFoundPage(),
        },
      );

  static PageRoute<dynamic> onGenerateMenuRoute(
    RouteSettings settings,
  ) =>
      PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, _, __) => switch (settings.name) {
          AppRoutes.home => const HomePage(),
          AppRoutes.categories => const CategoriesPage(),
          AppRoutes.support => const SupportPage(),
          AppRoutes.search => const SearchPage(),
          AppRoutes.cart => const CartPage(),
          AppRoutes.productDetail => ProductDetailPage(
              product: getArgs<ProductEntity>(settings.arguments),
            ),
          AppRoutes.categoryDetail => CategoryDetailPage(
              category: getArgs<String>(settings.arguments),
            ),
          _ => const NotFoundPage(navigateFromMenu: true),
        },
        transitionsBuilder: (context, opacity, _, child) {
          return FadeTransition(
            opacity: opacity,
            child: child,
          );
        },
      );

  static T getArgs<T>(Object? args) => args as T;
}
