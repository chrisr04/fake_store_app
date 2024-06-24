import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/accessibility/accessibility.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/features/cart/cart.dart';
import 'package:fake_store_app/features/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:provider/provider.dart';

class MockCartViewModel extends Mock implements CartViewModel {}

void main() {
  late MockCartViewModel cartViewModel;

  setUpAll(() async {
    await AppConfig.initAssets();
    cartViewModel = MockCartViewModel();
    when(() => cartViewModel.isProductAdded(any())).thenReturn(false);
  });

  group('PromotionList widget', () {
    testWidgets('renders HorizontalProductList with correct title and products',
        (WidgetTester tester) async {
      const products = [
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

      await mockNetworkImages(
        () async => tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<CartViewModel>(
                create: (context) => cartViewModel,
              ),
              FutureProvider<HomeSemantics>(
                create: (context) => HomeSemantics.load(),
                initialData: HomeSemantics.fromJson({}),
              ),
            ],
            child: const MaterialApp(
              home: Scaffold(
                body: PromotionList(
                  promotions: products,
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(HorizontalProductList), findsOneWidget);
      expect(find.text(StringValue.promotions), findsOneWidget);
      expect(find.text('Test Product'), findsOneWidget);
    });
  });
}
