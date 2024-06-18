import 'package:dartz/dartz.dart';
import 'package:fake_api/fake_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_app/features/search/search.dart';

import '../../../../utils/change_notifier_test_util.dart';

class MockFakeSearchRepository extends Mock implements FakeSearchRepository {}

void main() {
  late SearchViewModel searchViewModel;
  late MockFakeSearchRepository repository;

  setUpAll(() {
    repository = MockFakeSearchRepository();
    searchViewModel = SearchViewModel(repository);
  });

  group('SearchViewModel', () {
    const query = 'sandisk';
    ProductEntity product = const ProductEntity(
      id: 1,
      title: 'Sandisk',
      price: 100.0,
      description: 'Description',
      category: 'electronics',
      image: 'image.png',
      rating: RatingEntity(
        rate: 3.5,
        count: 1,
      ),
    );

    test('should check initial state is correct', () {
      expect(searchViewModel.state.products, isEmpty);
      expect(searchViewModel.state.error, equals(''));
      expect(searchViewModel.state.type, equals(SearchStateType.initial));
    });

    test('onResetSearch should change the current state to initial', () async {
      SearchState firstState = const SearchState();

      final notifierCounter = await changeNotifierTest<SearchViewModel>(
        notifier: searchViewModel,
        act: () => searchViewModel.onResetSearch(),
        onNotify: (notifierCounter) {
          firstState = searchViewModel.state;
        },
      );

      expect(firstState.products, isEmpty);
      expect(firstState.error, equals(''));
      expect(firstState.type, equals(SearchStateType.initial));
      expect(notifierCounter, equals(1));
    });

    test(
        'onSearchProducts should call searchProducts method and notify a loaded state type when request is success',
        () async {
      SearchState firstState = const SearchState();
      SearchState secondState = const SearchState();

      final notifierCounter = await changeNotifierTest<SearchViewModel>(
        notifier: searchViewModel,
        setUp: () {
          when(() => repository.searchProducts(query))
              .thenAnswer((_) async => Right([product]));
        },
        act: () => searchViewModel.onSearchProducts(query),
        onNotify: (notifierCounter) {
          switch (notifierCounter) {
            case 1:
              firstState = searchViewModel.state;
              break;
            case 2:
              secondState = searchViewModel.state;
              break;
          }
        },
      );

      expect(firstState.type, equals(SearchStateType.loading));
      expect(secondState.type, equals(SearchStateType.loaded));
      expect(secondState.products, equals([product]));
      expect(notifierCounter, equals(2));
    });

    test(
        'onSearchProducts should call searchProducts method and notify a error state type when request is failure',
        () async {
      SearchState firstState = const SearchState();
      SearchState secondState = const SearchState();

      final notifierCounter = await changeNotifierTest<SearchViewModel>(
        notifier: searchViewModel,
        setUp: () {
          when(() => repository.searchProducts(query)).thenAnswer(
            (_) async => const Left(RemoteFailure('Invalid request')),
          );
        },
        act: () => searchViewModel.onSearchProducts(query),
        onNotify: (notifierCounter) {
          switch (notifierCounter) {
            case 1:
              firstState = searchViewModel.state;
              break;
            case 2:
              secondState = searchViewModel.state;
              break;
          }
        },
      );

      expect(firstState.type, equals(SearchStateType.loading));
      expect(secondState.type, equals(SearchStateType.error));
      expect(secondState.error, equals('Invalid request'));
      expect(notifierCounter, equals(2));
    });
  });
}
