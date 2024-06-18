import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/features/catalog/catalog.dart';

import '../../../../mocks/fake_api_mocks.dart';

void main() {
  late FakeCatalogRemoteDataSource dataSource;
  late FakeApiClient client;
  setUpAll(() {
    client = FakeApiClient();
    client.initMocks(
      MockAuthController(),
      MockProductController(),
      MockUserController(),
      MockCartController(),
    );
    dataSource = FakeCatalogRemoteDataSource(client);
  });

  group('FakeCatalogRemoteDataSource getProductsByCategory', () {
    const category = 'electronics';
    test(
      'should return a List<ProductEntity> when request is success',
      () async {
        when(() => client.products.getProductsByCategory(category))
            .thenAnswer((_) async => []);

        final response = await dataSource.getProductsByCategory(category);

        expect(response, isA<List<ProductEntity>>());
      },
    );

    test(
      'should throws a FakeApiControllerException when request is failure',
      () async {
        when(() => client.products.getProductsByCategory(category))
            .thenThrow(ProductControllerException('Invalid request'));

        expect(
          () => dataSource.getProductsByCategory(category),
          throwsA(isA<FakeApiControllerException>()),
        );
      },
    );
  });
}
