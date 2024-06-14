part of 'home_viewmodel.dart';

enum HomeStateType { initial, loading, loaded, error }

class HomeState {
  const HomeState({
    this.promotions = const [],
    this.mostBought = const [],
    this.recommended = const [],
    this.recentlyAdded = const [],
    this.error = '',
    this.type = HomeStateType.initial,
  });

  final List<ProductEntity> promotions;
  final List<ProductEntity> mostBought;
  final List<ProductEntity> recommended;
  final List<ProductEntity> recentlyAdded;
  final String error;
  final HomeStateType type;

  HomeState copyWith({
    List<ProductEntity>? promotions,
    List<ProductEntity>? mostBought,
    List<ProductEntity>? recommended,
    List<ProductEntity>? recentlyAdded,
    String? error,
    HomeStateType? type,
  }) =>
      HomeState(
        promotions: promotions ?? this.promotions,
        mostBought: mostBought ?? this.mostBought,
        recommended: recommended ?? this.recommended,
        recentlyAdded: recentlyAdded ?? this.recentlyAdded,
        error: error ?? this.error,
        type: type ?? this.type,
      );
}
