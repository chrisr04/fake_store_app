import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/features/home/home.dart';

import '../../../../mocks/fake_api_mocks.dart';

void main() {
  late FakeHomeRemoteDataSource dataSource;
  late FakeApiClient client;
  late List<ProductEntity> products;

  setUpAll(() {
    client = FakeApiClient();
    client.initMocks(
      MockAuthController(),
      MockProductController(),
      MockUserController(),
      MockCartController(),
    );
    dataSource = FakeHomeRemoteDataSource(client);
    products = List<ProductEntity>.generate(
      10,
      (index) => ProductEntity(
        id: index,
        title: 'Product $index',
        price: 100.0 * index,
        description: 'Description $index',
        category: 'electronics',
        image: 'image.png',
        rating: const RatingEntity(
          rate: 3.5,
          count: 1,
        ),
      ),
    );
  });

  group('FakeHomeRemoteDataSource getPromotions', () {
    test(
      'should return a List<ProductEntity> when request is success',
      () async {
        when(() => client.products.getProducts())
            .thenAnswer((_) async => products);

        final response = await dataSource.getPromotions();

        expect(response, isA<List<ProductEntity>>());
      },
    );

    test(
      'should throws a FakeApiControllerException when request is failure',
      () async {
        when(() => client.products.getProducts())
            .thenThrow(ProductControllerException('Invalid request'));

        expect(
          () => dataSource.getPromotions(),
          throwsA(isA<FakeApiControllerException>()),
        );
      },
    );
  });

  group('FakeHomeRemoteDataSource getMostBought', () {
    test(
      'should return a List<ProductEntity> when request is success',
      () async {
        when(() => client.products.getProducts())
            .thenAnswer((_) async => products);

        final response = await dataSource.getMostBought();

        expect(response, isA<List<ProductEntity>>());
      },
    );

    test(
      'should throws a FakeApiControllerException when request is failure',
      () async {
        when(() => client.products.getProducts())
            .thenThrow(ProductControllerException('Invalid request'));

        expect(
          () => dataSource.getMostBought(),
          throwsA(isA<FakeApiControllerException>()),
        );
      },
    );
  });

  group('FakeHomeRemoteDataSource getRecommended', () {
    test(
      'should return a List<ProductEntity> when request is success',
      () async {
        when(() => client.products.getProducts())
            .thenAnswer((_) async => products);

        final response = await dataSource.getRecommended();

        expect(response, isA<List<ProductEntity>>());
      },
    );

    test(
      'should throws a FakeApiControllerException when request is failure',
      () async {
        when(() => client.products.getProducts())
            .thenThrow(ProductControllerException('Invalid request'));

        expect(
          () => dataSource.getRecommended(),
          throwsA(isA<FakeApiControllerException>()),
        );
      },
    );
  });

  group('FakeHomeRemoteDataSource getRecentlyAdded', () {
    test(
      'should return a List<ProductEntity> when request is success',
      () async {
        when(() => client.products.getProducts(params: any(named: 'params')))
            .thenAnswer((_) async => products);

        final response = await dataSource.getRecentlyAdded();

        expect(response, isA<List<ProductEntity>>());
      },
    );

    test(
      'should throws a FakeApiControllerException when request is failure',
      () async {
        when(() => client.products.getProducts(params: any(named: 'params')))
            .thenThrow(ProductControllerException('Invalid request'));

        expect(
          () => dataSource.getRecentlyAdded(),
          throwsA(isA<FakeApiControllerException>()),
        );
      },
    );
  });
}
