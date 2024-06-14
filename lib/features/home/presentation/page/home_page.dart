import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/navigation/navigation.dart';
import 'package:fake_store_app/features/home/presentation/viewmodel/home_viewmodel.dart';

part 'widgets/home_header.dart';
part 'widgets/home_search_bar.dart';
part 'widgets/address_row.dart';
part 'widgets/promotion_list.dart';
part 'widgets/most_bought_list.dart';
part 'widgets/recommended_list.dart';
part 'widgets/recently_added_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeViewModel>().state;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const HomeHeader(),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: FakeSpacing.sl,
              ),
              child: switch (state.type) {
                HomeStateType.loaded => Column(
                    children: [
                      PromotionList(
                        promotions: state.promotions,
                      ),
                      MostBoughtList(
                        mostBought: state.mostBought,
                      ),
                      RecommendedList(
                        recommended: state.recommended,
                      ),
                      RecentlyAddedList(
                        recentlyAdded: state.recentlyAdded,
                      ),
                    ],
                  ),
                HomeStateType.error => FakeErrorTemplate(
                    imagePath: AssetValue.errorIllustrationPng,
                    error: state.error,
                  ),
                _ => const Center(
                    child: CircularProgressIndicator(),
                  )
              },
            ),
          ),
        ],
      ),
    );
  }
}
