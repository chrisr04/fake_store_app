import 'package:fake_store_app/accessibility/accessibility.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/features/cart/cart.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  setUpAll(() async {
    await AppConfig.initAssets();
  });

  testWidgets('CartTitleRow displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      FutureProvider<CartSemantics>(
        create: (context) => CartSemantics.load(),
        initialData: CartSemantics.fromJson({}),
        child: const MaterialApp(
          home: Scaffold(
            body: CustomScrollView(
              slivers: [
                CartTitleRow(),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.byType(FakeIcon), findsOneWidget);
    expect(find.byIcon(Icons.shopping_cart_outlined), findsOneWidget);

    expect(find.text(StringValue.myCart), findsOneWidget);
  });
}
