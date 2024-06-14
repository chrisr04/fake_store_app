part of 'category_detail_viewmodel.dart';

enum CategoryDetailStateType { initial, loading, loaded, error }

class CategoryDetailState {
  const CategoryDetailState({
    this.products = const [],
    this.error = '',
    this.type = CategoryDetailStateType.initial,
  });

  final List<ProductEntity> products;
  final String error;
  final CategoryDetailStateType type;

  CategoryDetailState copyWith({
    List<ProductEntity>? products,
    String? error,
    CategoryDetailStateType? type,
  }) =>
      CategoryDetailState(
        products: products ?? this.products,
        error: error ?? this.error,
        type: type ?? this.type,
      );
}
