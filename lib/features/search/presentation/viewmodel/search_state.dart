part of 'search_viewmodel.dart';

enum SearchStateType { initial, loading, loaded, error }

class SearchState {
  const SearchState({
    this.products = const [],
    this.error = '',
    this.type = SearchStateType.initial,
  });

  final List<ProductEntity> products;
  final String error;
  final SearchStateType type;

  SearchState copyWith({
    List<ProductEntity>? products,
    String? error,
    SearchStateType? type,
  }) =>
      SearchState(
        products: products ?? this.products,
        error: error ?? this.error,
        type: type ?? this.type,
      );
}
