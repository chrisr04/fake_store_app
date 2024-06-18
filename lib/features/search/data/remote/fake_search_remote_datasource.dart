import 'package:fake_api/fake_api.dart';

class FakeSearchRemoteDataSource {
  const FakeSearchRemoteDataSource(this._client);

  final FakeApiClient _client;

  Future<List<ProductEntity>> searchProducts(String query) async {
    final products = await _client.products.getProducts();
    final lowerQuery = query.toLowerCase();
    final result = products.where(
      (product) =>
          product.title.toLowerCase().contains(lowerQuery) ||
          product.description.toLowerCase().contains(lowerQuery),
    );
    return result.toList();
  }
}
