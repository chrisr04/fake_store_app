import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/navigation/navigation.dart';
import 'package:fake_store_app/accessibility/accessibility.dart';
import 'package:fake_store_app/features/catalog/presentation/category_detail/viewmodel/category_detail_viewmodel.dart';

part 'widgets/category_header.dart';
part 'widgets/category_products.dart';

class CategoryDetailPage extends StatefulWidget {
  const CategoryDetailPage({
    super.key,
    required this.category,
  });

  final String category;

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  void initState() {
    Future.microtask(
      () => context
          .read<CategoryDetailViewModel>()
          .onLoadProducts(widget.category),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final semantics = context.watch<CategoryDetailSemantics>();
    return Scaffold(
      appBar: FakeSearchAppBar(
        hintText: StringValue.searchInFakeStore,
        showBackButton: true,
        readOnly: true,
        semanticLabel: semantics.searchBarHint.label,
        semanticsSortKey: OrdinalSortKey(semantics.searchBarHint.order),
        excludeSemantics: true,
        onTap: () => FakeNavigator.menu.pushNamed(AppRoutes.search),
      ),
      body: CustomScrollView(
        slivers: [
          CategoryHeader(
            category: widget.category,
          ),
          const CategoryProducts(),
        ],
      ),
    );
  }
}
