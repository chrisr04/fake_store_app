import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/features/cart/cart.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('EmptyCartMessage displays the correct content',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              EmptyCartMessage(),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(SliverFillRemaining), findsOneWidget);

    expect(find.byType(Center), findsOneWidget);

    expect(find.byType(FakeInformationTemplate), findsOneWidget);

    final FakeInformationTemplate fakeInfoTemplate =
        tester.widget(find.byType(FakeInformationTemplate));
    expect(fakeInfoTemplate.imagePath, AssetValue.emptyCartIllustrationPng);
    expect(fakeInfoTemplate.message, StringValue.thereAreNotProductsYet);
  });
}
