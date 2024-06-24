import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/features/cart/cart.dart';
import 'package:fake_store_app/navigation/navigation.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:provider/provider.dart';

class MockCartViewModel extends Mock implements CartViewModel {}

void main() {
  late MockCartViewModel cartViewModel;
  late List<ProductEntity> products;
  late CartProductEntity cartProduct;

  setUp(() async {
    await AppConfig.initAssets();
    cartViewModel = MockCartViewModel();
    products = const [
      ProductEntity(
        id: 1,
        title: 'Product 1',
        category: 'category',
        description: 'Description 1',
        price: 10.0,
        image: 'https://example.com/product1.jpg',
        rating: RatingEntity(
          rate: 3.0,
          count: 22,
        ),
      ),
    ];
    cartProduct = CartProductEntity(
      productId: products.first.id,
      quantity: 1,
      title: products.first.title,
      price: products.first.price,
      image: products.first.image,
    );
    registerFallbackValue(cartProduct);
  });

  Widget createWidget() => ChangeNotifierProvider<CartViewModel>(
        create: (context) => cartViewModel,
        child: MaterialApp(
          navigatorKey: FakeNavigator.menuNavigatorKey,
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(
                child: Text('Detail'),
              ),
            ),
          ),
          home: Scaffold(
            body: CustomScrollView(
              slivers: [
                VerticalProductSliverList(
                  products: products,
                ),
              ],
            ),
          ),
        ),
      );

  testWidgets('VerticalProductSliverList displays products',
      (WidgetTester tester) async {
    when(() => cartViewModel.isProductAdded(any())).thenReturn(false);

    await mockNetworkImages(
      () async => tester.pumpWidget(createWidget()),
    );

    for (final product in products) {
      expect(find.text(product.title), findsOneWidget);
      expect(find.text(product.description), findsOneWidget);
      expect(
        find.text('\$${product.price.toStringAsFixed(2).replaceAll('.', ',')}'),
        findsOneWidget,
      );
    }
  });

  testWidgets('VerticalProductSliverList displays add to cart interaction',
      (WidgetTester tester) async {
    when(() => cartViewModel.isProductAdded(any())).thenReturn(false);

    await mockNetworkImages(
      () async => tester.pumpWidget(createWidget()),
    );

    await tester.tap(find.text(StringValue.addToCart).first);
    await tester.pump();

    verify(() => cartViewModel.onAddProduct(any())).called(1);
  });

  testWidgets('VerticalProductSliverList remove from cart interaction',
      (WidgetTester tester) async {
    when(() => cartViewModel.isProductAdded(any())).thenReturn(true);

    await mockNetworkImages(
      () async => tester.pumpWidget(createWidget()),
    );

    await tester.tap(find.text(StringValue.removeFromCart).first);
    await tester.pump();

    verify(() => cartViewModel.onRemoveProduct(any())).called(1);
  });

  testWidgets('VerticalProductSliverList buy interaction',
      (WidgetTester tester) async {
    when(() => cartViewModel.isProductAdded(any())).thenReturn(true);

    await mockNetworkImages(
      () async => tester.pumpWidget(createWidget()),
    );

    await tester.tap(find.text(StringValue.buy).first);
    await tester.pump();
  });

  testWidgets('VerticalProductSliverList tap interaction',
      (WidgetTester tester) async {
    when(() => cartViewModel.isProductAdded(any())).thenReturn(true);

    await mockNetworkImages(
      () async => tester.pumpWidget(createWidget()),
    );

    await tester.tap(find.byType(FakeHorizontalProductCard).first);
    await tester.pumpAndSettle();

    expect(find.text('Detail'), findsOneWidget);
  });
}
