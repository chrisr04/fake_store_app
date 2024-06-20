part of '../menu_page.dart';

class MenuNavigationBar extends StatefulWidget {
  const MenuNavigationBar({super.key, required this.onPageChanged});

  final ValueChanged<int> onPageChanged;

  @override
  State<MenuNavigationBar> createState() => _MenuNavigationBarState();
}

class _MenuNavigationBarState extends State<MenuNavigationBar> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CartViewModel>().state;
    final products = state.cart?.products ?? [];
    final totalProducts = _getTotalProducts(products);
    return FakeBottomNavigationBar(
      selectedIndex: _selectedPage,
      onDestinationChanged: _onChangePage,
      destinations: [
        const NavigationDestination(
          key: KeyValue.menuHomeIconBtn,
          icon: FakeIcon(Icons.home_outlined),
          selectedIcon: FakeIcon(Icons.home),
          label: StringValue.home,
        ),
        const NavigationDestination(
          key: KeyValue.menuCatalogIconBtn,
          icon: FakeIcon(Icons.shopping_bag_outlined),
          selectedIcon: FakeIcon(Icons.shopping_bag),
          label: StringValue.catalog,
        ),
        const NavigationDestination(
          key: KeyValue.menuSupportIconBtn,
          icon: FakeIcon(Icons.headset_mic_outlined),
          selectedIcon: FakeIcon(Icons.headset_mic),
          label: StringValue.support,
        ),
        NavigationDestination(
          key: KeyValue.menuCartIconBtn,
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
    );
  }

  void _onChangePage(int index) {
    setState(() {
      _selectedPage = index;
    });
    widget.onPageChanged(_selectedPage);
  }

  int _getTotalProducts(List<CartProductEntity> products) {
    return products.fold(
      0,
      (value, product) => value + product.quantity,
    );
  }
}
