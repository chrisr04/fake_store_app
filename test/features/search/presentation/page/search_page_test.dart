import 'package:dartz/dartz.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:provider/provider.dart';
import 'package:fake_store_app/features/cart/cart.dart';
import 'package:fake_store_app/features/search/search.dart';

class MockFakeSearchRepository extends Mock implements FakeSearchRepository {}

class MockSearchViewModel extends SearchViewModel {
  MockSearchViewModel(super.repository);

  SearchState _fakeState = const SearchState();

  @override
  SearchState get state => _fakeState;

  void changeStateAndNotify(SearchState newState) {
    _fakeState = newState;
    notifyListeners();
  }
}

class MockCartViewModel extends Mock implements CartViewModel {}

void main() {
  late MockFakeSearchRepository repository;
  late MockSearchViewModel searchViewModel;
  late MockCartViewModel cartViewModel;

  setUp(() async {
    await AppConfig.init();
    repository = MockFakeSearchRepository();
    searchViewModel = MockSearchViewModel(repository);
    cartViewModel = MockCartViewModel();
    when(() => cartViewModel.isProductAdded(any())).thenReturn(false);
  });

  Widget createWidget() => ChangeNotifierProvider<CartViewModel>(
        create: (context) => cartViewModel,
        child: ChangeNotifierProvider<SearchViewModel>(
          create: (_) => searchViewModel,
          child: const MaterialApp(
            home: SearchPage(),
          ),
        ),
      );

  group('SearchPage Widget Tests', () {
    testWidgets('Initial state shows no search message',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidget());
      expect(find.byType(NoSearchMessage), findsOneWidget);
    });

    testWidgets('Shows loading indicator when loading',
        (WidgetTester tester) async {
      searchViewModel.changeStateAndNotify(
        const SearchState(
          type: SearchStateType.loading,
        ),
      );
      await tester.pumpWidget(createWidget());
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Shows error message when there is an error',
        (WidgetTester tester) async {
      const errorMessage = 'An error occurred';
      searchViewModel.changeStateAndNotify(
        const SearchState(
          type: SearchStateType.error,
          error: errorMessage,
        ),
      );
      await tester.pumpWidget(createWidget());
      await tester.pump();
      expect(find.byType(ErrorMessage), findsOneWidget);
      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('Shows search results when loaded',
        (WidgetTester tester) async {
      const products = [
        ProductEntity(
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
      searchViewModel.changeStateAndNotify(
        const SearchState(
          type: SearchStateType.loaded,
          products: products,
        ),
      );

      await mockNetworkImages(
        () => tester.pumpWidget(
          createWidget(),
        ),
      );

      await tester.pump();
      expect(find.byType(SearchResultList), findsOneWidget);
      expect(find.text('Test Product'), findsOneWidget);
    });

    testWidgets('Submits search when search button is pressed',
        (WidgetTester tester) async {
      when(() => repository.searchProducts('query'))
          .thenAnswer((_) async => const Right([]));
      await tester.pumpWidget(createWidget());
      await tester.enterText(find.byType(FakeTextField), 'query');
      await tester.tap(find.byIcon(Icons.search));
      await tester.pump();
      verify(() => repository.searchProducts('query')).called(1);
    });
  });
}
