import 'package:dartz/dartz.dart';
import 'package:fake_api/fake_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_app/features/home/home.dart';

import '../../../../utils/change_notifier_test_util.dart';

class MockFakeHomeRepository extends Mock implements FakeHomeRepository {}

void main() {
  late HomeViewModel homeViewModel;
  late MockFakeHomeRepository repository;

  setUpAll(() {
    repository = MockFakeHomeRepository();
    homeViewModel = HomeViewModel(repository);
  });

  group('HomeViewModel', () {
    ProductEntity product = const ProductEntity(
      id: 1,
      title: 'Product 1',
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
      expect(homeViewModel.state.promotions, isEmpty);
      expect(homeViewModel.state.mostBought, isEmpty);
      expect(homeViewModel.state.recentlyAdded, isEmpty);
      expect(homeViewModel.state.recentlyAdded, isEmpty);
      expect(homeViewModel.state.error, equals(''));
      expect(
        homeViewModel.state.type,
        equals(HomeStateType.initial),
      );
    });

    test(
        'onLoadSections should call getAllProducts method and notify a loaded state type when request is success',
        () async {
      HomeState firstState = const HomeState();
      HomeState secondState = const HomeState();

      final notifierCounter = await changeNotifierTest<HomeViewModel>(
        notifier: homeViewModel,
        setUp: () {
          when(() => repository.getAllProducts())
              .thenAnswer((_) async => Right([product]));
        },
        act: () => homeViewModel.onLoadSections(),
        onNotify: (notifierCounter) {
          switch (notifierCounter) {
            case 1:
              firstState = homeViewModel.state;
              break;
            case 2:
              secondState = homeViewModel.state;
              break;
          }
        },
      );

      expect(firstState.type, equals(HomeStateType.loading));
      expect(secondState.type, equals(HomeStateType.loaded));
      expect(secondState.promotions, equals([product]));
      expect(secondState.mostBought, equals([product]));
      expect(secondState.recommended, equals([product]));
      expect(secondState.recentlyAdded, equals([product]));
      expect(notifierCounter, equals(2));
    });

    test(
        'onLoadSections should call getAllProducts method and notify a error state type when request is failure',
        () async {
      HomeState firstState = const HomeState();
      HomeState secondState = const HomeState();

      final notifierCounter = await changeNotifierTest<HomeViewModel>(
        notifier: homeViewModel,
        setUp: () {
          when(() => repository.getAllProducts()).thenAnswer(
            (_) async => const Left(RemoteFailure('Invalid request')),
          );
        },
        act: () => homeViewModel.onLoadSections(),
        onNotify: (notifierCounter) {
          switch (notifierCounter) {
            case 1:
              firstState = homeViewModel.state;
              break;
            case 2:
              secondState = homeViewModel.state;
              break;
          }
        },
      );

      expect(firstState.type, equals(HomeStateType.loading));
      expect(secondState.type, equals(HomeStateType.error));
      expect(secondState.error, equals('Invalid request'));
      expect(notifierCounter, equals(2));
    });
  });
}
