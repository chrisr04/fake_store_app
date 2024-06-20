import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/features/cart/cart.dart';
import 'package:fake_store_app/features/catalog/catalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockCartViewModel extends Mock implements CartViewModel {}

void main() {
  late ProductEntity product;
  late MockCartViewModel cartViewModel;

  setUpAll(() {
    product = const ProductEntity(
      id: 1,
      title: 'Product 1',
      price: 100.0,
      description: 'Description',
      category: 'electronics',
      image: 'https://example.com/image.jpg',
      rating: RatingEntity(
        rate: 3.5,
        count: 1,
      ),
    );

    cartViewModel = MockCartViewModel();
  });

  group('AddToCartFooter', () {
    testWidgets('should show remove text on button when isProductAdded is true',
        (WidgetTester tester) async {
      when(() => cartViewModel.isProductAdded(product.id)).thenReturn(true);

      await tester.pumpWidget(
        ChangeNotifierProvider<CartViewModel>(
          create: (_) => cartViewModel,
          child: MaterialApp(
            home: Scaffold(
              body: AddToCartFooter(
                product: product,
              ),
            ),
          ),
        ),
      );

      expect(find.text(StringValue.removeFromCart), findsOneWidget);

      await tester.tap(find.text(StringValue.removeFromCart));
      await tester.pump();
    });

    testWidgets('should show add text on button when isProductAdded is false',
        (WidgetTester tester) async {
      when(() => cartViewModel.isProductAdded(product.id)).thenReturn(false);

      final testWidget = ChangeNotifierProvider<CartViewModel>(
        create: (_) => cartViewModel,
        child: MaterialApp(
          home: Scaffold(
            body: AddToCartFooter(
              product: product,
            ),
          ),
        ),
      );

      await tester.pumpWidget(testWidget);

      expect(find.text(StringValue.addToCart), findsOneWidget);

      await tester.tap(find.text(StringValue.addToCart));
      await tester.pump();
    });
  });
}
