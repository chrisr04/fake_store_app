import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/features/cart/cart.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:provider/provider.dart';

class MockCartViewModel extends Mock implements CartViewModel {}

void main() {
  late MockCartViewModel cartViewModel;
  late CartEntity filledCart;
  setUp(() {
    cartViewModel = MockCartViewModel();
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
    registerFallbackValue(filledCart.products.first);
  });

  Widget createWidget() {
    return ChangeNotifierProvider<CartViewModel>(
      create: (context) => cartViewModel,
      child: const MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            slivers: [CartProductList()],
          ),
        ),
      ),
    );
  }

  group('CartProductList Widget Test', () {
    testWidgets('displays EmptyCartMessage when cart is empty',
        (WidgetTester tester) async {
      when(() => cartViewModel.state).thenReturn(const CartState());

      await tester.pumpWidget(createWidget());

      await tester.pump();

      expect(find.byType(EmptyCartMessage), findsOneWidget);
      expect(find.byType(FakeShoppingCartCard), findsNothing);
    });

    testWidgets('displays products when cart is not empty',
        (WidgetTester tester) async {
      when(() => cartViewModel.state).thenReturn(CartState(cart: filledCart));

      await mockNetworkImages(
        () async => tester.pumpWidget(createWidget()),
      );

      await tester.pump();

      expect(find.byType(EmptyCartMessage), findsNothing);
      expect(find.byType(FakeShoppingCartCard), findsOneWidget);
    });

    testWidgets('calls onRemoveProduct when delete button is pressed',
        (WidgetTester tester) async {
      when(() => cartViewModel.state).thenReturn(CartState(cart: filledCart));

      await mockNetworkImages(
        () async => tester.pumpWidget(createWidget()),
      );

      await tester.pump();
      await tester.tap(find.text(StringValue.delete));
      await tester.pump();

      verify(() => cartViewModel.onRemoveProduct(1)).called(1);
    });

    testWidgets(
        'calls onUpdateProductQuantity when remove quantity button is pressed',
        (WidgetTester tester) async {
      when(() => cartViewModel.state).thenReturn(CartState(cart: filledCart));

      await mockNetworkImages(
        () async => tester.pumpWidget(createWidget()),
      );

      await tester.pump();
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      verify(
        () => cartViewModel.onUpdateProductQuantity(any()),
      ).called(1);
    });

    testWidgets(
        'calls onUpdateProductQuantity when add quantity button is pressed',
        (WidgetTester tester) async {
      when(() => cartViewModel.state).thenReturn(CartState(cart: filledCart));

      await mockNetworkImages(
        () async => tester.pumpWidget(createWidget()),
      );

      await tester.pump();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      verify(
        () => cartViewModel.onUpdateProductQuantity(any()),
      ).called(1);
    });

    testWidgets(
        'calls onUpdateProductQuantity when quantity is changed manually',
        (WidgetTester tester) async {
      when(() => cartViewModel.state).thenReturn(CartState(cart: filledCart));

      await mockNetworkImages(
        () async => tester.pumpWidget(createWidget()),
      );

      await tester.pump();

      await tester.enterText(find.byType(FakeTextField).first, '5');
      await tester.pump();

      verify(
        () => cartViewModel.onUpdateProductQuantity(any()),
      ).called(1);
    });
  });
}
