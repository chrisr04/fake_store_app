import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/features/catalog/catalog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CategoryDetailState', () {
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

    test('should have correct default values', () {
      const state = CategoryDetailState();

      expect(state.products, []);
      expect(state.error, '');
      expect(state.type, CategoryDetailStateType.initial);
    });

    test('copyWith should retain old values if not provided', () {
      const initialState = CategoryDetailState();
      final updatedState = initialState.copyWith();

      expect(updatedState.products, []);
      expect(updatedState.error, '');
      expect(updatedState.type, CategoryDetailStateType.initial);
    });

    test('copyWith updates only the specified values', () {
      const initialState = CategoryDetailState();
      final updatedState = initialState.copyWith(
        products: [product],
        error: 'An error occurred',
        type: CategoryDetailStateType.error,
      );

      expect(updatedState.products, [product]);
      expect(updatedState.error, 'An error occurred');
      expect(updatedState.type, CategoryDetailStateType.error);
    });
  });
}
