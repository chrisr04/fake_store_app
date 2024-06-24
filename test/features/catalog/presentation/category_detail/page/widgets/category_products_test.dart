import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/accessibility/accessibility.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/features/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:provider/provider.dart';
import 'package:fake_store_app/features/catalog/catalog.dart';

class MockCategoryDetailViewModel extends Mock
    implements CategoryDetailViewModel {}

class MockCartViewModel extends Mock implements CartViewModel {}

void main() {
  late MockCategoryDetailViewModel categoryDetailViewModel;
  late MockCartViewModel cartViewModel;
  late ProductEntity product;

  setUpAll(() async {
    await AppConfig.initAssets();
    categoryDetailViewModel = MockCategoryDetailViewModel();
    cartViewModel = MockCartViewModel();
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
    when(() => cartViewModel.isProductAdded(product.id)).thenReturn(false);
  });

  Widget createWidget() => MultiProvider(
        providers: [
          ChangeNotifierProvider<CartViewModel>(
            create: (context) => cartViewModel,
          ),
          ChangeNotifierProvider<CategoryDetailViewModel>(
            create: (context) => categoryDetailViewModel,
          ),
          FutureProvider<CategoryDetailSemantics>(
            create: (context) => CategoryDetailSemantics.load(),
            initialData: CategoryDetailSemantics.fromJson({}),
          ),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: CustomScrollView(
              slivers: [
                CategoryProducts(),
              ],
            ),
          ),
        ),
      );

  group('CategoryProducts', () {
    testWidgets('displays CircularProgressIndicator when state is loading',
        (WidgetTester tester) async {
      when(() => categoryDetailViewModel.state).thenReturn(
        const CategoryDetailState(type: CategoryDetailStateType.loading),
      );

      await mockNetworkImages(
        () async => tester.pumpWidget(createWidget()),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays VerticalProductSliverList when state is loaded',
        (WidgetTester tester) async {
      when(() => categoryDetailViewModel.state).thenReturn(
        CategoryDetailState(
          type: CategoryDetailStateType.loaded,
          products: [product],
        ),
      );

      await mockNetworkImages(
        () async => tester.pumpWidget(createWidget()),
      );

      expect(find.byType(VerticalProductSliverList), findsOneWidget);
      expect(find.text('Test Product'), findsOneWidget);
    });

    testWidgets('displays ErrorMessage when state is error',
        (WidgetTester tester) async {
      when(() => categoryDetailViewModel.state).thenReturn(
        const CategoryDetailState(
          type: CategoryDetailStateType.error,
          error: 'An error occurred',
        ),
      );

      await mockNetworkImages(
        () async => tester.pumpWidget(createWidget()),
      );

      expect(find.byType(ErrorMessage), findsOneWidget);
      expect(find.text('An error occurred'), findsOneWidget);
    });
  });
}
