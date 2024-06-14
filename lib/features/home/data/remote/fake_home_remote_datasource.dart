import 'package:fake_api/fake_api.dart';

class FakeHomeRemoteDataSource {
  const FakeHomeRemoteDataSource(this._client);

  final FakeApiClient _client;

  Future<List<ProductEntity>> getPromotions() async {
    final products = await _client.products.getProducts();
    products.sort((p1, p2) => p1.price.compareTo(p2.price));
    return products.take(7).toList();
  }

  Future<List<ProductEntity>> getMostBought() async {
    final products = await _client.products.getProducts();
    products.sort((p1, p2) => p1.rating.count.compareTo(p2.rating.count));
    return products.take(7).toList();
  }

  Future<List<ProductEntity>> getRecommended() async {
    final products = await _client.products.getProducts();
    products.sort((p1, p2) => p2.rating.rate.compareTo(p1.rating.rate));
    return products.take(7).toList();
  }

  Future<List<ProductEntity>> getRecentlyAdded() async {
    final products = await _client.products.getProducts(
      params: FakeApiParams(
        sort: FakeApiSort.asc,
      ),
    );
    return products.take(7).toList();
  }
}
