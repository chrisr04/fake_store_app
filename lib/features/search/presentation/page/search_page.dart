import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/features/search/presentation/viewmodel/search_viewmodel.dart';

part 'widgets/no_search_message.dart';
part 'widgets/empty_result_message.dart';
part 'widgets/search_result_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    Future.microtask(
      () => context.read<SearchViewModel>().onResetSearch(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SearchViewModel>();
    return Scaffold(
      appBar: FakeSearchAppBar(
        key: KeyValue.searchQueryInput,
        hintText: StringValue.searchByNameOrDescription,
        showBackButton: true,
        onSubmit: viewModel.onSearchProducts,
      ),
      body: switch (viewModel.state.type) {
        SearchStateType.loaded => SearchResultList(
            products: viewModel.state.products,
          ),
        SearchStateType.error => ErrorMessage(
            error: viewModel.state.error,
          ),
        SearchStateType.loading => const Center(
            child: CircularProgressIndicator(),
          ),
        _ => const NoSearchMessage(),
      },
    );
  }
}
