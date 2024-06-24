import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/features/cart/cart.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_app/accessibility/accessibility.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockCartViewModel extends Mock implements CartViewModel {}

void main() {
  late MockCartViewModel cartViewModel;
  late CartEntity filledCart;
  late CartEntity emptyCart;

  setUp(() async {
    await AppConfig.initAssets();

    cartViewModel = MockCartViewModel();
    emptyCart = CartEntity(
      id: 123,
      userId: 456,
      date: DateTime(2023, 6, 15),
      products: [],
    );
    filledCart = CartEntity(
      id: 123,
      userId: 456,
      date: DateTime(2023, 6, 15),
      products: [
        const CartProductEntity(
          productId: 1,
          quantity: 2,
          title: 'Product 1',
          price: 20.0,
          image: 'https://example.com/test_image.jpg',
        ),
      ],
    );
  });

  Widget createWidget() => MultiProvider(
        providers: [
          ChangeNotifierProvider<CartViewModel>(
            create: (context) => cartViewModel,
          ),
          FutureProvider<CartSemantics>(
            create: (context) => CartSemantics.load(),
            initialData: CartSemantics.fromJson({}),
          ),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: TotalCartFooter(),
          ),
        ),
      );

  group('TotalCartFooter', () {
    testWidgets('displays nothing when cart is empty',
        (WidgetTester tester) async {
      when(() => cartViewModel.state).thenReturn(CartState(cart: emptyCart));

      await tester.pumpWidget(createWidget());

      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('displays total and checkout button when cart is not empty',
        (WidgetTester tester) async {
      when(() => cartViewModel.state).thenReturn(CartState(cart: filledCart));

      await tester.pumpWidget(createWidget());

      expect(find.text(StringValue.total), findsOneWidget);
      expect(find.text('\$40,00'), findsOneWidget);
      expect(find.text('Checkout'), findsOneWidget);
      expect(find.byType(FakeButtonPrimary), findsOneWidget);
    });

    testWidgets('displays total and checkout button when cart is not empty',
        (WidgetTester tester) async {
      when(() => cartViewModel.state).thenReturn(CartState(cart: filledCart));

      await tester.pumpWidget(createWidget());

      expect(find.text(StringValue.total), findsOneWidget);
      expect(find.text('\$40,00'), findsOneWidget);
      expect(find.text('Checkout'), findsOneWidget);
      expect(find.byType(FakeButtonPrimary), findsOneWidget);

      await tester.tap(find.byType(FakeButtonPrimary));
      await tester.pump();
    });
  });
}
