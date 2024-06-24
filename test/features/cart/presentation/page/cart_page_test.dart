import 'package:fake_store_app/accessibility/accessibility.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/features/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockCartViewModel extends Mock implements CartViewModel {}

void main() {
  setUpAll(() async {
    await AppConfig.initAssets();
  });

  testWidgets('CartPage has a title row, product list, and footer',
      (WidgetTester tester) async {
    final mockViewModel = MockCartViewModel();

    when(() => mockViewModel.state).thenReturn(const CartState());

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<CartViewModel>(
            create: (context) => mockViewModel,
          ),
          FutureProvider<CartSemantics>(
            create: (context) => CartSemantics.load(),
            initialData: CartSemantics.fromJson({}),
          ),
        ],
        child: const MaterialApp(
          home: CartPage(),
        ),
      ),
    );

    expect(find.byType(CartTitleRow), findsOneWidget);

    expect(find.byType(CartProductList), findsOneWidget);

    expect(find.byType(TotalCartFooter), findsOneWidget);
  });
}
