import 'package:dartz/dartz.dart';
import 'package:fake_api/fake_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_app/features/catalog/catalog.dart';

import '../../../../../helpers/helpers.dart';

class MockFakeCatalogRepository extends Mock implements FakeCatalogRepository {}

void main() {
  late CategoryDetailViewModel categoryDetailViewModel;
  late MockFakeCatalogRepository repository;

  setUpAll(() {
    repository = MockFakeCatalogRepository();
    categoryDetailViewModel = CategoryDetailViewModel(repository);
  });

  group('CategoryDetailViewModel', () {
    const category = 'electronics';

    test('should check initial state is correct', () {
      expect(categoryDetailViewModel.state.products, isEmpty);
      expect(categoryDetailViewModel.state.error, equals(''));
      expect(
        categoryDetailViewModel.state.type,
        equals(CategoryDetailStateType.initial),
      );
    });

    test(
        'onLoadProducts should call createCart method and notify a loaded state type when request is success',
        () async {
      CategoryDetailState firstState = const CategoryDetailState();
      CategoryDetailState secondState = const CategoryDetailState();

      final notifierCounter = await changeNotifierTest<CategoryDetailViewModel>(
        notifier: categoryDetailViewModel,
        setUp: () {
          when(() => repository.getCategoryProducts(category))
              .thenAnswer((_) async => const Right([]));
        },
        act: () => categoryDetailViewModel.onLoadProducts(category),
        onNotify: (notifierCounter) {
          switch (notifierCounter) {
            case 1:
              firstState = categoryDetailViewModel.state;
              break;
            case 2:
              secondState = categoryDetailViewModel.state;
              break;
          }
        },
      );

      expect(firstState.type, equals(CategoryDetailStateType.loading));
      expect(secondState.type, equals(CategoryDetailStateType.loaded));
      expect(secondState.products, isEmpty);
      expect(notifierCounter, equals(2));
    });

    test(
        'onLoadProducts should call createCart method and notify a error state type when request is failure',
        () async {
      CategoryDetailState firstState = const CategoryDetailState();
      CategoryDetailState secondState = const CategoryDetailState();

      final notifierCounter = await changeNotifierTest<CategoryDetailViewModel>(
        notifier: categoryDetailViewModel,
        setUp: () {
          when(() => repository.getCategoryProducts(category)).thenAnswer(
            (_) async => const Left(RemoteFailure('Invalid request')),
          );
        },
        act: () => categoryDetailViewModel.onLoadProducts(category),
        onNotify: (notifierCounter) {
          switch (notifierCounter) {
            case 1:
              firstState = categoryDetailViewModel.state;
              break;
            case 2:
              secondState = categoryDetailViewModel.state;
              break;
          }
        },
      );

      expect(firstState.type, equals(CategoryDetailStateType.loading));
      expect(secondState.type, equals(CategoryDetailStateType.error));
      expect(secondState.error, equals('Invalid request'));
      expect(notifierCounter, equals(2));
    });
  });
}
