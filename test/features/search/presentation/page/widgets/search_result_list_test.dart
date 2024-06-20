import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fake_api/fake_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/features/cart/cart.dart';
import 'package:fake_store_app/features/search/search.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:provider/provider.dart';

class MockCartViewModel extends Mock implements CartViewModel {}

void main() {
  late MockCartViewModel cartViewModel;

  setUpAll(() {
    cartViewModel = MockCartViewModel();
  });

  group('SearchResultList', () {
    testWidgets('displays EmptyResultMessage when products list is empty',
        (WidgetTester tester) async {
      const emptyProductList = <ProductEntity>[];

      await tester.pumpWidget(
        ChangeNotifierProvider<CartViewModel>(
          create: (context) => cartViewModel,
          child: const MaterialApp(
            home: Scaffold(
              body: SearchResultList(products: emptyProductList),
            ),
          ),
        ),
      );

      expect(find.byType(EmptyResultMessage), findsOneWidget);
      expect(find.byType(VerticalProductList), findsNothing);
    });

    testWidgets('displays VerticalProductList when products list is not empty',
        (WidgetTester tester) async {
      const productList = [
        ProductEntity(
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
        ),
      ];

      when(() => cartViewModel.isProductAdded(any())).thenReturn(false);

      await mockNetworkImages(
        () => tester.pumpWidget(
          ChangeNotifierProvider<CartViewModel>(
            create: (context) => cartViewModel,
            child: const MaterialApp(
              home: Scaffold(
                body: SearchResultList(products: productList),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(EmptyResultMessage), findsNothing);
      expect(find.byType(VerticalProductList), findsOneWidget);
    });
  });
}
