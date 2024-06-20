import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/features/catalog/catalog.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

void main() {
  testWidgets('DetailHeader displays correctly', (WidgetTester tester) async {
    const product = ProductEntity(
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

    await mockNetworkImages(
      () async => tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DetailHeader(product: product),
          ),
        ),
      ),
    );

    expect(find.byType(FakeImageNetwork), findsOneWidget);
    expect(find.byType(FakeLightAppBar), findsOneWidget);

    final FakeImageNetwork imageWidget =
        tester.widget(find.byType(FakeImageNetwork));
    expect(imageWidget.url, equals('https://example.com/image.jpg'));
  });
}
