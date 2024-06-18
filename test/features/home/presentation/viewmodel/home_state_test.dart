import 'package:fake_api/fake_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_app/features/home/home.dart';

void main() {
  group('HomeState', () {
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

    test('should have correct initial values', () {
      const state = HomeState();

      expect(state.promotions, []);
      expect(state.mostBought, []);
      expect(state.recommended, []);
      expect(state.recentlyAdded, []);
      expect(state.error, '');
      expect(state.type, HomeStateType.initial);
    });

    test('copyWith should return a new instance with updated values', () {
      const initialState = HomeState();

      final promotions = [product];
      final mostBought = [product];
      final recommended = [product];
      final recentlyAdded = [product];
      const error = 'An error occurred';
      const type = HomeStateType.loaded;

      final newState = initialState.copyWith(
        promotions: promotions,
        mostBought: mostBought,
        recommended: recommended,
        recentlyAdded: recentlyAdded,
        error: error,
        type: type,
      );

      expect(newState.promotions, promotions);
      expect(newState.mostBought, mostBought);
      expect(newState.recommended, recommended);
      expect(newState.recentlyAdded, recentlyAdded);
      expect(newState.error, error);
      expect(newState.type, type);

      expect(initialState.promotions, []);
      expect(initialState.mostBought, []);
      expect(initialState.recommended, []);
      expect(initialState.recentlyAdded, []);
      expect(initialState.error, '');
      expect(initialState.type, HomeStateType.initial);
    });

    test('copyWith should retain old values if not provided', () {
      const initialState = HomeState(
        promotions: [product],
        mostBought: [product],
        recommended: [product],
        recentlyAdded: [product],
        error: 'Initial error',
        type: HomeStateType.loading,
      );

      final newState = initialState.copyWith();

      expect(newState.promotions, initialState.promotions);
      expect(newState.mostBought, initialState.mostBought);
      expect(newState.recommended, initialState.recommended);
      expect(newState.recentlyAdded, initialState.recentlyAdded);
      expect(newState.error, initialState.error);
      expect(newState.type, initialState.type);
    });
  });
}
