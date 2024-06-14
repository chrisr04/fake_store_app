import 'package:flutter/material.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/navigation/navigation.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FakeSearchAppBar(
        onTap: () => FakeNavigator.menu.pushNamed(
          AppRoutes.search,
        ),
        hintText: StringValue.searchInFakeStore,
        readOnly: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: FakeSpacing.md,
          vertical: FakeSpacing.lg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FakeHorizontalImageCard(
              onTap: () => FakeNavigator.menu.pushNamed(
                AppRoutes.categoryDetail,
                arguments: CategoryHelper.electronics,
              ),
              image: AssetValue.electronicsPng,
              title: StringValue.electronics,
              imageHeight: 60.0,
              titleWeight: FontWeight.w700,
            ),
            const FakeSpacerM(),
            FakeHorizontalImageCard(
              onTap: () => FakeNavigator.menu.pushNamed(
                AppRoutes.categoryDetail,
                arguments: CategoryHelper.womensClothing,
              ),
              image: AssetValue.womenClothingPng,
              title: StringValue.womenClothing,
              imageHeight: 60.0,
              titleWeight: FontWeight.w700,
            ),
            const FakeSpacerM(),
            FakeHorizontalImageCard(
              onTap: () => FakeNavigator.menu.pushNamed(
                AppRoutes.categoryDetail,
                arguments: CategoryHelper.mensClothing,
              ),
              image: AssetValue.menClothingPng,
              title: StringValue.menClothing,
              imageHeight: 60.0,
              titleWeight: FontWeight.w700,
            ),
            const FakeSpacerM(),
            FakeHorizontalImageCard(
              onTap: () => FakeNavigator.menu.pushNamed(
                AppRoutes.categoryDetail,
                arguments: CategoryHelper.jewelery,
              ),
              image: AssetValue.jeweleryPng,
              title: StringValue.jewelery,
              imageHeight: 60.0,
              titleWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}
