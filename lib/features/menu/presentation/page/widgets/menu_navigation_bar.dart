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
    final semantics = context.watch<MenuSemantics>();
    final state = context.watch<CartViewModel>().state;
    final products = state.cart?.products ?? [];
    final totalProducts = _getTotalProducts(products);
    return FakeBottomNavigationBar(
      selectedIndex: _selectedPage,
      onDestinationChanged: _onChangePage,
      destinations: [
        NavigationDestination(
          key: KeyValue.menuHomeIconBtn,
          icon: Semantics(
            label: semantics.homeItem.label,
            sortKey: OrdinalSortKey(semantics.homeItem.order),
            child: const FakeIcon(Icons.home_outlined),
          ),
          selectedIcon: Semantics(
            label: semantics.homeItem.label,
            sortKey: OrdinalSortKey(semantics.homeItem.order),
            child: const FakeIcon(Icons.home),
          ),
          label: StringValue.home,
        ),
        NavigationDestination(
          key: KeyValue.menuCatalogIconBtn,
          icon: Semantics(
            label: semantics.catalogItem.label,
            sortKey: OrdinalSortKey(semantics.catalogItem.order),
            child: const FakeIcon(Icons.shopping_bag_outlined),
          ),
          selectedIcon: Semantics(
            label: semantics.catalogItem.label,
            sortKey: OrdinalSortKey(semantics.catalogItem.order),
            child: const FakeIcon(Icons.shopping_bag),
          ),
          label: StringValue.catalog,
        ),
        NavigationDestination(
          key: KeyValue.menuSupportIconBtn,
          icon: Semantics(
            label: semantics.supportItem.label,
            sortKey: OrdinalSortKey(semantics.supportItem.order),
            child: const FakeIcon(Icons.headset_mic_outlined),
          ),
          selectedIcon: Semantics(
            label: semantics.supportItem.label,
            sortKey: OrdinalSortKey(semantics.supportItem.order),
            child: const FakeIcon(Icons.headset_mic),
          ),
          label: StringValue.support,
        ),
        NavigationDestination(
          key: KeyValue.menuCartIconBtn,
          icon: Badge(
            label: Semantics(
              label: semantics.cartItemCount.label,
              sortKey: OrdinalSortKey(semantics.cartItemCount.order),
              child: FakeTextSmall(totalProducts.toString()),
            ),
            child: Semantics(
              label: semantics.cartItem.label,
              sortKey: OrdinalSortKey(semantics.cartItem.order),
              child: const FakeIcon(Icons.shopping_cart_outlined),
            ),
          ),
          selectedIcon: Badge(
            label: Semantics(
              label: semantics.cartItemCount.label,
              sortKey: OrdinalSortKey(semantics.cartItemCount.order),
              child: FakeTextSmall(totalProducts.toString()),
            ),
            child: Semantics(
              label: semantics.cartItem.label,
              sortKey: OrdinalSortKey(semantics.cartItem.order),
              child: const FakeIcon(Icons.shopping_cart),
            ),
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
