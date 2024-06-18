import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/features/search/search.dart';

import '../../../../mocks/fake_api_mocks.dart';

void main() {
  late FakeSearchRemoteDataSource dataSource;
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
    dataSource = FakeSearchRemoteDataSource(client);

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

  group('FakeSearchRemoteDataSource searchProducts', () {
    test(
      'should return a List<ProductEntity> when query match with title',
      () async {
        const query = 'Product 1';
        when(() => client.products.getProducts())
            .thenAnswer((_) async => products);

        final response = await dataSource.searchProducts(query);

        expect(response, isA<List<ProductEntity>>());
      },
    );

    test(
      'should return a List<ProductEntity> when query match with description',
      () async {
        const query = 'Description 1';
        when(() => client.products.getProducts())
            .thenAnswer((_) async => products);

        final response = await dataSource.searchProducts(query);

        expect(response, isA<List<ProductEntity>>());
      },
    );

    test(
      'should throws a FakeApiControllerException when request is failure',
      () async {
        when(() => client.products.getProducts())
            .thenThrow(ProductControllerException('Invalid request'));

        expect(
          () => dataSource.searchProducts('sandisk'),
          throwsA(isA<FakeApiControllerException>()),
        );
      },
    );
  });
}
