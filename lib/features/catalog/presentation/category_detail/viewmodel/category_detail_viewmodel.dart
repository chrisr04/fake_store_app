import 'package:fake_api/fake_api.dart';
import 'package:flutter/material.dart';
import 'package:fake_store_app/features/catalog/domain/domain.dart';

part 'category_detail_state.dart';

class CategoryDetailViewModel with ChangeNotifier {
  CategoryDetailViewModel(this._repository);

  final FakeCatalogRepository _repository;
  CategoryDetailState state = const CategoryDetailState();

  void onLoadProducts(String category) async {
    state = state.copyWith(type: CategoryDetailStateType.loading);
    notifyListeners();
    final failureOrProducts = await _repository.getCategoryProducts(category);
    failureOrProducts.fold(
      (failure) {
        state = state.copyWith(
          error: failure.message,
          type: CategoryDetailStateType.error,
        );
      },
      (products) {
        state = state.copyWith(
          products: products,
          type: CategoryDetailStateType.loaded,
        );
      },
    );
    notifyListeners();
  }
}
