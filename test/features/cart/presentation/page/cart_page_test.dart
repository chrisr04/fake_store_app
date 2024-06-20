import 'package:fake_store_app/features/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockCartViewModel extends Mock implements CartViewModel {}

void main() {
  testWidgets('CartPage has a title row, product list, and footer',
      (WidgetTester tester) async {
    final mockViewModel = MockCartViewModel();

    when(() => mockViewModel.state).thenReturn(const CartState());

    await tester.pumpWidget(
      ChangeNotifierProvider<CartViewModel>(
        create: (context) => mockViewModel,
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
