import 'package:dartz/dartz.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/core/config/app_config.dart';
import 'package:fake_store_app/features/cart/cart.dart';
import 'package:fake_store_app/features/home/home.dart';
import 'package:fake_store_app/features/menu/menu.dart';
import 'package:fake_store_app/features/search/search.dart';
import 'package:fake_store_app/navigation/fake_navigator.dart';
import 'package:fake_store_app/navigation/navigation.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockAppConfig extends Mock implements AppConfig {}

class MockFakeCartRepository extends Mock implements FakeCartRepository {}

class MockHomeViewModel extends Mock implements HomeViewModel {}

class MockSearchViewModel extends Mock implements SearchViewModel {}

class MockCartViewModel extends CartViewModel {
  MockCartViewModel(super.repository);

  CartState _fakeState = const CartState();

  @override
  CartState get state => _fakeState;

  set state(CartState newState) {
    _fakeState = newState;
    notifyListeners();
  }
}

void main() {
  late MockCartViewModel cartViewModel;
  late MockHomeViewModel homeViewModel;
  late MockSearchViewModel searchViewModel;
  late MockFakeCartRepository repository;
  late AppConfig appConfig;
  late CartEntity cart;
  late UserEntity user;

  setUp(() async {
    await AppConfig.init();
    cart = CartEntity(
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
    user = const UserEntity(
      id: 1,
      name: UserNameEntity(
        firstname: 'John',
        lastname: 'Doe',
      ),
      username: 'johndoe',
      email: 'john.doe@example.com',
      phone: '123-456-7890',
      address: AddressEntity(
        city: 'New York',
        street: '123 Main St',
        zipcode: '10001',
        number: 1,
        geolocation: GeolocationEntity(
          lat: '34.5464',
          long: '345.343',
        ),
      ),
    );
    homeViewModel = MockHomeViewModel();
    searchViewModel = MockSearchViewModel();
    repository = MockFakeCartRepository();
    cartViewModel = MockCartViewModel(repository);
    appConfig = MockAppConfig();
    registerFallbackValue(cart);

    when(() => appConfig.currentUser).thenReturn(user);
    when(() => homeViewModel.state).thenReturn(const HomeState());
    when(() => searchViewModel.state).thenReturn(const SearchState());
    when(() => repository.createCart(any()))
        .thenAnswer((_) async => Right(cart));
  });

  Widget createMenuPage() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartViewModel>(
          create: (_) => cartViewModel,
        ),
        ChangeNotifierProvider<HomeViewModel>(
          create: (_) => homeViewModel,
        ),
        ChangeNotifierProvider<SearchViewModel>(
          create: (_) => searchViewModel,
        ),
        Provider<AppConfig>(create: (_) => appConfig),
      ],
      child: MaterialApp(
        home: const MenuPage(),
        navigatorKey: FakeNavigator.rootNavigatorKey,
      ),
    );
  }

  testWidgets('MenuPage navigation works correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(createMenuPage());

    final bottomNavigationBarFinder = find.byType(MenuNavigationBar);
    expect(bottomNavigationBarFinder, findsOneWidget);

    await tester.tap(find.byIcon(Icons.shopping_bag_outlined));
    await tester.pumpAndSettle();

    expect(find.text(StringValue.electronics), findsOneWidget);

    await tester.tap(find.byIcon(Icons.headset_mic_outlined));
    await tester.pumpAndSettle();

    expect(find.text(StringValue.helloDoYouNeedHelp), findsOneWidget);

    await tester.tap(find.byIcon(Icons.shopping_cart_outlined));
    await tester.pumpAndSettle();

    expect(find.text(StringValue.myCart), findsOneWidget);

    await tester.tap(find.byIcon(Icons.home_outlined));
    await tester.pump();

    expect(find.text(StringValue.searchInFakeStore), findsOneWidget);
  });

  testWidgets('MenuPage pop navigation works correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(createMenuPage());

    final bottomNavigationBarFinder = find.byType(MenuNavigationBar);
    expect(bottomNavigationBarFinder, findsOneWidget);

    await tester.tap(find.byIcon(Icons.shopping_bag_outlined));
    await tester.pumpAndSettle();

    expect(find.text(StringValue.electronics), findsOneWidget);

    await tester.tap(find.byType(FakeSearchAppBar));
    await tester.pumpAndSettle();

    expect(find.byType(NavigatorPopHandler), findsOneWidget);

    final navigatorPop =
        tester.widget<NavigatorPopHandler>(find.byType(NavigatorPopHandler));

    navigatorPop.onPop!();
    await tester.pumpAndSettle();

    expect(find.text(StringValue.electronics), findsOneWidget);
  });

  testWidgets('MenuPage shows error snackbar on cart error',
      (WidgetTester tester) async {
    await tester.pumpWidget(createMenuPage());

    cartViewModel.state = const CartState(
      type: CartStateType.error,
      error: 'Test error',
    );

    await tester.pump();

    expect(find.text('Test error'), findsOneWidget);
  });
}
