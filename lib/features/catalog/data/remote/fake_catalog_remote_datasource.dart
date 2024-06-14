import 'package:fake_api/fake_api.dart';

class FakeCatalogRemoteDataSource {
  const FakeCatalogRemoteDataSource(this._client);

  final FakeApiClient _client;

  Future<ProductEntity> getProductDetail(int id) =>
      _client.products.getProductById(id);

  Future<List<ProductEntity>> getProductsByCategory(String category) =>
      _client.products.getProductsByCategory(category);
}
