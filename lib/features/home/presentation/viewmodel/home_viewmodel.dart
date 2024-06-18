import 'package:fake_api/fake_api.dart';
import 'package:flutter/material.dart';
import 'package:fake_store_app/features/home/domain/domain.dart';

part 'home_state.dart';

class HomeViewModel with ChangeNotifier {
  HomeViewModel(this._repository) {
    onLoadSections();
  }

  final FakeHomeRepository _repository;
  HomeState _state = const HomeState();
  HomeState get state => _state;

  void onLoadSections() async {
    _state = _state.copyWith(type: HomeStateType.loading);
    notifyListeners();

    final failureOrProducts = await _repository.getAllProducts();
    failureOrProducts.fold(
      (failure) {
        _state = _state.copyWith(
          error: failure.message,
          type: HomeStateType.error,
        );
      },
      (products) {
        products.sort((p1, p2) => p1.price.compareTo(p2.price));
        final promotions = products.take(7).toList();
        products.sort((p1, p2) => p1.rating.count.compareTo(p2.rating.count));
        final mostBought = products.take(7).toList();
        products.sort((p1, p2) => p2.rating.rate.compareTo(p1.rating.rate));
        final recommended = products.take(7).toList();
        products.sort((p1, p2) => p2.title.compareTo(p1.title));
        final recentlyAdded = products.take(7).toList();

        _state = _state.copyWith(
          promotions: promotions,
          mostBought: mostBought,
          recommended: recommended,
          recentlyAdded: recentlyAdded,
          type: HomeStateType.loaded,
        );
      },
    );
    notifyListeners();
  }
}
