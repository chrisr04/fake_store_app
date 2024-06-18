import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/features/catalog/catalog.dart';

class MockFakeCatalogRemoteDataSource extends Mock
    implements FakeCatalogRemoteDataSource {}

void main() {
  late MockFakeCatalogRemoteDataSource dataSource;
  late FakeCatalogRepository repository;
  setUpAll(() {
    dataSource = MockFakeCatalogRemoteDataSource();
    repository = FakeCatalogRepositoryImpl(dataSource);
  });

  group('FakeCatalogRepositoryImpl getProductsByCategory', () {
    const category = 'electronics';
    test(
      'should return a Right(List<ProductEntity>) when request is success',
      () async {
        when(() => dataSource.getProductsByCategory(category))
            .thenAnswer((_) async => []);

        final result = await repository.getCategoryProducts(category);

        expect(result, isA<Right>());
        expect((result as Right).value, isA<List<ProductEntity>>());
      },
    );

    test(
      'should throws a Left(RemoteFailure) when request is failure',
      () async {
        when(() => dataSource.getProductsByCategory(category))
            .thenThrow(ProductControllerException('Invalid request'));

        final result = await repository.getCategoryProducts(category);

        expect(result, isA<Left>());
        expect((result as Left).value, isA<RemoteFailure>());
      },
    );
  });
}
