import 'package:fake_api/fake_api.dart';
import 'package:provider/provider.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/features/catalog/catalog.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_app/accessibility/accessibility.dart';

void main() {
  setUpAll(() async {
    await AppConfig.initAssets();
  });

  testWidgets('ProductInfoBody displays product information correctly',
      (WidgetTester tester) async {
    const product = ProductEntity(
      id: 1,
      title: 'Sample Product',
      price: 19.99,
      description: 'This is a sample product description.',
      category: 'electronics',
      image: 'https://example.com/image.jpg',
      rating: RatingEntity(
        rate: 4.5,
        count: 1,
      ),
    );

    await tester.pumpWidget(
      FutureProvider<ProductDetailSemantics>(
        create: (context) => ProductDetailSemantics.load(),
        initialData: ProductDetailSemantics.fromJson({}),
        child: const MaterialApp(
          home: Scaffold(
            body: ProductInfoBody(product: product),
          ),
        ),
      ),
    );

    expect(find.text('Sample Product'), findsOneWidget);
    expect(find.text('\$19,99'), findsOneWidget);
    expect(find.byType(FakeRatingStars), findsOneWidget);
    expect(find.text('This is a sample product description.'), findsOneWidget);
    expect(find.text('electronics'), findsOneWidget);
  });
}
