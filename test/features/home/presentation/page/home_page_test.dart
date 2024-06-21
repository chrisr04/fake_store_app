import 'package:dartz/dartz.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_app/features/cart/cart.dart';
import 'package:fake_store_app/features/home/home.dart';
import 'package:provider/provider.dart';

class MockCartViewModel extends Mock implements CartViewModel {}

class MockAppConfig extends Mock implements AppConfig {}

class MockFakeHomeRepository extends Mock implements FakeHomeRepository {}

class MockHomeViewModel extends HomeViewModel {
  MockHomeViewModel(super.repository);

  HomeState _fakeState = const HomeState();

  @override
  HomeState get state => _fakeState;

  void changeStateAndNotify(HomeState newState) {
    _fakeState = newState;
    notifyListeners();
  }
}

void main() {
  late MockCartViewModel cartViewModel;
  late MockHomeViewModel homeViewModel;
  late MockFakeHomeRepository repository;
  late List<ProductEntity> products;
  late MockAppConfig appConfig;

  setUp(() async {
    await AppConfig.init();
    appConfig = MockAppConfig();
    repository = MockFakeHomeRepository();
    homeViewModel = MockHomeViewModel(repository);
    cartViewModel = MockCartViewModel();
    products = [
      const ProductEntity(
        id: 1,
        title: 'Test Product',
        price: 100.0,
        description: 'This is a test product',
        category: 'electronics',
        image: 'https://example.com/image.jpg',
        rating: RatingEntity(
          rate: 3.5,
          count: 1,
        ),
      ),
    ];

    when(() => cartViewModel.isProductAdded(any())).thenReturn(false);

    when(() => repository.getAllProducts())
        .thenAnswer((_) async => Right(products));
  });

  Widget createWidget() => MultiProvider(
        providers: [
          Provider<AppConfig>(create: (context) => appConfig),
          ChangeNotifierProvider<HomeViewModel>(
            create: (context) => homeViewModel,
          ),
          ChangeNotifierProvider<CartViewModel>(
            create: (context) => cartViewModel,
          ),
        ],
        child: const MaterialApp(
          home: HomePage(),
        ),
      );

  group('HomePage Widget Test', () {
    testWidgets('renders loading state', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders error state', (WidgetTester tester) async {
      const error = 'Sample error message';

      homeViewModel.changeStateAndNotify(
        const HomeState(
          type: HomeStateType.error,
          error: error,
        ),
      );

      await tester.pumpWidget(createWidget());

      expect(find.text(error), findsOneWidget);
    });

    testWidgets('renders loaded state', (WidgetTester tester) async {
      homeViewModel.changeStateAndNotify(
        const HomeState(
          type: HomeStateType.loaded,
          promotions: [],
          mostBought: [],
          recommended: [],
          recentlyAdded: [],
        ),
      );

      await tester.pumpWidget(createWidget());

      expect(find.byType(PromotionList), findsOneWidget);
      expect(find.byType(MostBoughtList), findsOneWidget);
      expect(find.byType(RecommendedList), findsOneWidget);
      expect(find.byType(RecentlyAddedList), findsOneWidget);
    });
  });
}
