import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/features/cart/cart.dart';
import 'package:fake_store_app/navigation/navigation.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late final cartViewModel = context.read<CartViewModel>();
  int _selectedPage = 0;

  @override
  void initState() {
    _createCart();
    cartViewModel.addListener(_cartViewModelListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CartViewModel>().state;
    final products = state.cart?.products ?? [];
    final totalProducts = _getTotalProducts(products);
    return Scaffold(
      body: NavigatorPopHandler(
        onPop: () => FakeNavigator.menu.pop(),
        child: Navigator(
          key: AppConfig.menuNavigatorKey,
          onGenerateRoute: RouteGenerator.onGenerateMenuRoute,
          initialRoute: AppRoutes.home,
        ),
      ),
      bottomNavigationBar: FakeBottomNavigationBar(
        onDestinationChanged: _onChangePage,
        destinations: [
          const NavigationDestination(
            icon: FakeIcon(Icons.home_outlined),
            selectedIcon: FakeIcon(Icons.home),
            label: StringValue.home,
          ),
          const NavigationDestination(
            icon: FakeIcon(Icons.shopping_bag_outlined),
            selectedIcon: FakeIcon(Icons.shopping_bag),
            label: StringValue.catalog,
          ),
          const NavigationDestination(
            icon: FakeIcon(Icons.headset_mic_outlined),
            selectedIcon: FakeIcon(Icons.headset_mic),
            label: StringValue.support,
          ),
          NavigationDestination(
            icon: Badge(
              label: FakeTextSmall(totalProducts.toString()),
              child: const FakeIcon(Icons.shopping_cart_outlined),
            ),
            selectedIcon: Badge(
              label: FakeTextSmall(totalProducts.toString()),
              child: const FakeIcon(Icons.shopping_cart),
            ),
            label: StringValue.cart,
          ),
        ],
        selectedIndex: _selectedPage,
      ),
    );
  }

  @override
  void dispose() {
    cartViewModel.removeListener(_cartViewModelListener);
    super.dispose();
  }

  void _onChangePage(int index) {
    setState(() {
      _selectedPage = index;
      switch (index) {
        case 0:
          FakeNavigator.menu.pushNamed(AppRoutes.home);
          break;
        case 1:
          FakeNavigator.menu.pushNamed(AppRoutes.categories);
          break;
        case 2:
          FakeNavigator.menu.pushNamed(AppRoutes.support);
          break;
        case 3:
          FakeNavigator.menu.pushNamed(AppRoutes.cart);
          break;
      }
    });
  }

  void _createCart() {
    Future.microtask(
      () {
        final user = context.read<AppConfig>().currentUser;
        context.read<CartViewModel>().onCreateCart(
              CartEntity(
                id: 0,
                userId: user?.id ?? 0,
                date: DateTime.now(),
                products: [],
              ),
            );
      },
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

  int _getTotalProducts(List<CartProductEntity> products) {
    return products.fold(
      0,
      (value, product) => value + product.quantity,
    );
  }
}
