part of '../home_page.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: FakeSpacing.md,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withOpacity(0.08),
              offset: const Offset(0.0, 1.0),
              blurRadius: 12.0,
            ),
          ],
        ),
        child: FakeTextFieldSearch(
          onTap: () => FakeNavigator.menu.pushNamed(
            AppRoutes.search,
          ),
          readOnly: true,
          hintText: StringValue.searchInFakeStore,
        ),
      ),
    );
  }
}
