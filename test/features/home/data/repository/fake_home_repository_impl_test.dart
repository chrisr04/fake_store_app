import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/features/home/home.dart';

class MockFakeHomeRemoteDataSource extends Mock
    implements FakeHomeRemoteDataSource {}

void main() {
  late FakeHomeRemoteDataSource dataSource;
  late FakeHomeRepository repository;
  late List<ProductEntity> products;

  setUpAll(() {
    dataSource = MockFakeHomeRemoteDataSource();
    repository = FakeHomeRepositoryImpl(dataSource);
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

  group('FakeHomeRepositoryImpl getAllProducts', () {
    test(
      'should return a Right(List<ProductEntity>) when request is success',
      () async {
        when(() => dataSource.getAllProducts())
            .thenAnswer((_) async => products);

        final result = await repository.getAllProducts();

        expect(result, isA<Right>());
        expect((result as Right).value, isA<List<ProductEntity>>());
      },
    );

    test(
      'should throws a Left(RemoteFailure) when request is failure',
      () async {
        when(() => dataSource.getAllProducts())
            .thenThrow(ProductControllerException('Invalid request'));

        final result = await repository.getAllProducts();

        expect(result, isA<Left>());
        expect((result as Left).value, isA<RemoteFailure>());
      },
    );
  });
}
