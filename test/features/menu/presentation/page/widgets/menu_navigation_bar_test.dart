import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/features/cart/cart.dart';
import 'package:fake_store_app/features/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockCartViewModel extends Mock implements CartViewModel {}

void main() {
  late MockCartViewModel cartViewModel;

  setUp(() {
    cartViewModel = MockCartViewModel();
  });

  testWidgets('MenuNavigationBar test', (WidgetTester tester) async {
    int selectedPage = 0;

    when(() => cartViewModel.state).thenAnswer(
      (_) => CartState(
        cart: CartEntity(
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
        ),
      ),
    );

    await tester.pumpWidget(
      ChangeNotifierProvider<CartViewModel>(
        create: (context) => cartViewModel,
        child: MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return MenuNavigationBar(
                  onPageChanged: (int index) {
                    setState(() {
                      selectedPage = index;
                    });
                  },
                );
              },
            ),
          ),
        ),
      ),
    );

    expect(selectedPage, 0);
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
    expect(find.byIcon(Icons.headset_mic_outlined), findsOneWidget);
    expect(find.byIcon(Icons.shopping_cart_outlined), findsOneWidget);
    expect(find.text('2'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.shopping_bag_outlined));
    await tester.pump();

    expect(selectedPage, 1);

    await tester.tap(find.byIcon(Icons.headset_mic_outlined));
    await tester.pump();

    expect(selectedPage, 2);

    await tester.tap(find.byIcon(Icons.shopping_cart_outlined));
    await tester.pump();

    expect(selectedPage, 3);

    await tester.tap(find.byIcon(Icons.home_outlined));
    await tester.pump();

    expect(selectedPage, 0);
  });
}
