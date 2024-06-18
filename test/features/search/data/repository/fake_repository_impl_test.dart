import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/features/search/search.dart';

class MockFakeSearchRemoteDataSource extends Mock
    implements FakeSearchRemoteDataSource {}

void main() {
  late MockFakeSearchRemoteDataSource dataSource;
  late FakeSearchRepository repository;
  late List<ProductEntity> products;

  setUpAll(() {
    dataSource = MockFakeSearchRemoteDataSource();
    repository = FakeSearchRepositoryImpl(dataSource);
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
    const query = 'Product 1';
    test(
      'should return a Right(List<ProductEntity>) when query request is success',
      () async {
        when(() => dataSource.searchProducts(query))
            .thenAnswer((_) async => products);

        final result = await repository.searchProducts(query);

        expect(result, isA<Right>());
        expect((result as Right).value, isA<List<ProductEntity>>());
      },
    );

    test(
      'should throws a Left(RemoteFailure) when request is failure',
      () async {
        when(() => dataSource.searchProducts(query))
            .thenThrow(ProductControllerException('Invalid request'));

        final result = await repository.searchProducts('sandisk');

        expect(result, isA<Left>());
        expect((result as Left).value, isA<RemoteFailure>());
      },
    );
  });
}
