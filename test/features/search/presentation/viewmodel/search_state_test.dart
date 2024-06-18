import 'package:fake_api/fake_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_app/features/search/search.dart';

void main() {
  group('SearchState', () {
    const product = ProductEntity(
      id: 1,
      title: 'Product 1',
      price: 100.0,
      description: 'Description',
      category: 'electronics',
      image: 'image.png',
      rating: RatingEntity(
        rate: 3.5,
        count: 1,
      ),
    );

    test('should have default values', () {
      const state = SearchState();

      expect(state.products, []);
      expect(state.error, '');
      expect(state.type, SearchStateType.initial);
    });

    test('should create state with given values', () {
      final products = [product];
      const error = 'An error occurred';
      const type = SearchStateType.error;

      final state = SearchState(
        products: products,
        error: error,
        type: type,
      );

      expect(state.products, products);
      expect(state.error, error);
      expect(state.type, type);
    });

    test('copyWith should return a copy with updated values', () {
      final initialProducts = [product];
      final newProducts = [product];
      const initialError = 'Initial error';
      const newError = 'New error';
      const initialType = SearchStateType.loading;
      const newType = SearchStateType.loaded;

      final state = SearchState(
        products: initialProducts,
        error: initialError,
        type: initialType,
      );

      final copiedState = state.copyWith(
        products: newProducts,
        error: newError,
        type: newType,
      );

      expect(copiedState.products, newProducts);
      expect(copiedState.error, newError);
      expect(copiedState.type, newType);
    });

    test('copyWith should retain old values if not provided', () {
      final initialProducts = [product];
      const initialError = 'Initial error';
      const initialType = SearchStateType.loading;

      final state = SearchState(
        products: initialProducts,
        error: initialError,
        type: initialType,
      );

      final copiedState = state.copyWith();

      expect(copiedState.products, initialProducts);
      expect(copiedState.error, initialError);
      expect(copiedState.type, initialType);
    });
  });
}
