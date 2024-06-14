import 'package:fake_api/fake_api.dart';
import 'package:flutter/material.dart';
import 'package:fake_store_app/features/search/domain/domain.dart';

part 'search_state.dart';

class SearchViewModel with ChangeNotifier {
  SearchViewModel(this._repository);

  final FakeSearchRepository _repository;
  SearchState state = const SearchState();

  void onResetSearch() {
    state = const SearchState();
    notifyListeners();
  }

  void onSearchProducts(String query) async {
    state = state.copyWith(type: SearchStateType.loading);
    notifyListeners();
    final failureOrResults = await _repository.searchProducts(query);
    failureOrResults.fold(
      (failure) {
        state = state.copyWith(
          error: failure.message,
          type: SearchStateType.error,
        );
      },
      (results) {
        state = state.copyWith(
          products: results,
          type: SearchStateType.loaded,
        );
      },
    );
    notifyListeners();
  }
}
