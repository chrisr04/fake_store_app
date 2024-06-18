import 'package:fake_api/fake_api.dart';
import 'package:flutter/material.dart';
import 'package:fake_store_app/features/catalog/domain/domain.dart';

part 'category_detail_state.dart';

class CategoryDetailViewModel with ChangeNotifier {
  CategoryDetailViewModel(this._repository);

  final FakeCatalogRepository _repository;
  CategoryDetailState _state = const CategoryDetailState();
  CategoryDetailState get state => _state;

  Future<void> onLoadProducts(String category) async {
    _state = _state.copyWith(type: CategoryDetailStateType.loading);
    notifyListeners();
    final failureOrProducts = await _repository.getCategoryProducts(category);
    failureOrProducts.fold(
      (failure) {
        _state = _state.copyWith(
          error: failure.message,
          type: CategoryDetailStateType.error,
        );
      },
      (products) {
        _state = _state.copyWith(
          products: products,
          type: CategoryDetailStateType.loaded,
        );
      },
    );
    notifyListeners();
  }
}
