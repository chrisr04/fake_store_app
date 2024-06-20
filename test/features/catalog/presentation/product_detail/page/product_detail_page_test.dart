import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/features/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_app/features/catalog/catalog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:provider/provider.dart';

class MockCartViewModel extends Mock implements CartViewModel {}

void main() {
  late ProductEntity product;
  late MockCartViewModel cartViewModel;

  setUpAll(() {
    product = const ProductEntity(
      id: 1,
      title: 'Test Product',
      price: 100.0,
      description: 'This is a test product',
      category: 'electronics',
      image: 'https://example.com/image.jpg',
      rating: RatingEntity(
        rate: 3.5,
        count: 1,
      ),
    );

    cartViewModel = MockCartViewModel();
  });

  testWidgets('ProductDetailPage renders correctly',
      (WidgetTester tester) async {
    when(() => cartViewModel.isProductAdded(product.id)).thenReturn(true);

    await mockNetworkImages(
      () async => tester.pumpWidget(
        ChangeNotifierProvider<CartViewModel>(
          create: (_) => cartViewModel,
          child: MaterialApp(
            home: ProductDetailPage(
              product: product,
            ),
          ),
        ),
      ),
    );

    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('This is a test product'), findsOneWidget);

    expect(find.byType(DetailHeader), findsOneWidget);
    expect(find.byType(ProductInfoBody), findsOneWidget);
    expect(find.byType(AddToCartFooter), findsOneWidget);
  });
}
