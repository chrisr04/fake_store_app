import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/features/cart/cart.dart';
import 'package:fake_store_app/navigation/navigation.dart';

part 'widgets/menu_navigation_bar.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late final cartViewModel = context.read<CartViewModel>();

  @override
  void initState() {
    Future.microtask(() {
      cartViewModel.addListener(_cartViewModelListener);
      _createCart();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NavigatorPopHandler(
        onPop: () => FakeNavigator.menu.pop(),
        child: Navigator(
          key: AppConfig.menuNavigatorKey,
          onGenerateRoute: RouteGenerator.onGenerateMenuRoute,
          initialRoute: AppRoutes.home,
        ),
      ),
      bottomNavigationBar: MenuNavigationBar(
        onPageChanged: _navigateToPage,
      ),
    );
  }

  @override
  void dispose() {
    cartViewModel.removeListener(_cartViewModelListener);
    super.dispose();
  }

  void _createCart() {
    final user = context.read<AppConfig>().currentUser;
    cartViewModel.onCreateCart(
      CartEntity(
        id: 0,
        userId: user?.id ?? 0,
        date: DateTime.now(),
        products: [],
      ),
    );
  }

  void _cartViewModelListener() {
    final state = context.read<CartViewModel>().state;
    switch (state.type) {
      case CartStateType.error:
        FakeSnackBar.showError(
          context,
          message: state.error,
        );
        break;
      default:
    }
  }

  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        FakeNavigator.menu.pushNamedAndRemoveUntil(
          AppRoutes.home,
          (_) => false,
        );
        break;
      case 1:
        FakeNavigator.menu.pushNamedAndRemoveUntil(
          AppRoutes.categories,
          (_) => false,
        );
        break;
      case 2:
        FakeNavigator.menu.pushNamedAndRemoveUntil(
          AppRoutes.support,
          (_) => false,
        );
        break;
      case 3:
        FakeNavigator.menu.pushNamedAndRemoveUntil(
          AppRoutes.cart,
          (_) => false,
        );
        break;
    }
  }
}
