import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:provider/provider.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/navigation/navigation.dart';
import 'package:fake_store_app/accessibility/accessibility.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final semantics = context.watch<CategoriesSemantics>();
    return Scaffold(
      appBar: FakeSearchAppBar(
        hintText: StringValue.searchInFakeStore,
        readOnly: true,
        semanticsSortKey: OrdinalSortKey(semantics.searchBarHint.order),
        semanticLabel: semantics.searchBarHint.label,
        excludeSemantics: true,
        semanticFocused: true,
        onTap: () => FakeNavigator.menu.pushNamed(
          AppRoutes.search,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: FakeSpacing.md,
          vertical: FakeSpacing.lg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MergeSemantics(
              child: Semantics(
                label: semantics.categoryItem.label,
                child: FakeHorizontalImageCard(
                  image: AssetValue.electronicsPng,
                  title: StringValue.electronics,
                  imageHeight: 60.0,
                  titleWeight: FontWeight.w700,
                  onTap: () => FakeNavigator.menu.pushNamed(
                    AppRoutes.categoryDetail,
                    arguments: CategoryHelper.electronics,
                  ),
                ),
              ),
            ),
            const FakeSpacerM(),
            MergeSemantics(
              child: Semantics(
                label: semantics.categoryItem.label,
                child: FakeHorizontalImageCard(
                  image: AssetValue.womenClothingPng,
                  title: StringValue.womenClothing,
                  imageHeight: 60.0,
                  titleWeight: FontWeight.w700,
                  onTap: () => FakeNavigator.menu.pushNamed(
                    AppRoutes.categoryDetail,
                    arguments: CategoryHelper.womensClothing,
                  ),
                ),
              ),
            ),
            const FakeSpacerM(),
            MergeSemantics(
              child: Semantics(
                label: semantics.categoryItem.label,
                child: FakeHorizontalImageCard(
                  image: AssetValue.menClothingPng,
                  title: StringValue.menClothing,
                  imageHeight: 60.0,
                  titleWeight: FontWeight.w700,
                  onTap: () => FakeNavigator.menu.pushNamed(
                    AppRoutes.categoryDetail,
                    arguments: CategoryHelper.mensClothing,
                  ),
                ),
              ),
            ),
            const FakeSpacerM(),
            MergeSemantics(
              child: Semantics(
                label: semantics.categoryItem.label,
                child: FakeHorizontalImageCard(
                  image: AssetValue.jeweleryPng,
                  title: StringValue.jewelery,
                  imageHeight: 60.0,
                  titleWeight: FontWeight.w700,
                  onTap: () => FakeNavigator.menu.pushNamed(
                    AppRoutes.categoryDetail,
                    arguments: CategoryHelper.jewelery,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
