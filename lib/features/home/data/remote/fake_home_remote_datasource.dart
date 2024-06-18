import 'package:fake_api/fake_api.dart';

class FakeHomeRemoteDataSource {
  const FakeHomeRemoteDataSource(this._client);

  final FakeApiClient _client;

  Future<List<ProductEntity>> getAllProducts() async {
    return _client.products.getProducts();
  }
}
