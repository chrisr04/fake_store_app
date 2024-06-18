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

    final failureOrPromotions = await _repository.getPromotions();
    final promotionsResult = failureOrPromotions.fold(
      (failure) => failure,
      (promotion) => promotion,
    );

    if (failureOrPromotions.isLeft()) {
      final failure = promotionsResult as Failure;
      _state =
          _state.copyWith(error: failure.message, type: HomeStateType.error);
      notifyListeners();
      return;
    }

    final failureOrMostBought = await _repository.getMostBought();
    final mostBoughtResult = failureOrMostBought.fold(
      (failure) => failure,
      (mostBought) => mostBought,
    );

    if (failureOrMostBought.isLeft()) {
      final failure = mostBoughtResult as Failure;
      _state =
          _state.copyWith(error: failure.message, type: HomeStateType.error);
      notifyListeners();
      return;
    }

    final failureOrRecommended = await _repository.getRecommended();
    final recommendedResult = failureOrRecommended.fold(
      (failure) => failure,
      (recommended) => recommended,
    );

    if (failureOrRecommended.isLeft()) {
      final failure = recommendedResult as Failure;
      _state =
          _state.copyWith(error: failure.message, type: HomeStateType.error);
      notifyListeners();
      return;
    }

    final failureOrRecently = await _repository.getRecentlyAdded();
    final recentlyResult = failureOrRecently.fold(
      (failure) => failure,
      (recently) => recently,
    );

    if (failureOrRecently.isLeft()) {
      final failure = recentlyResult as Failure;
      _state =
          _state.copyWith(error: failure.message, type: HomeStateType.error);
      notifyListeners();
      return;
    }

    _state = _state.copyWith(
      promotions: promotionsResult as List<ProductEntity>,
      mostBought: mostBoughtResult as List<ProductEntity>,
      recommended: recommendedResult as List<ProductEntity>,
      recentlyAdded: recentlyResult as List<ProductEntity>,
      type: HomeStateType.loaded,
    );
    notifyListeners();
  }
}
