import 'package:fake_store_app/common/values/values.dart';
import 'package:fake_store_app/navigation/navigation.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({
    super.key,
    this.navigateFromMenu = false,
  });

  final bool navigateFromMenu;

  @override
  Widget build(BuildContext context) {
    return FakeErrorPage(
      appBarTitle: StringValue.error,
      imagePath: AssetValue.notFoundIllustrationPng,
      error: StringValue.routeNotFound,
      description: StringValue.pleaseCheckThePath,
      buttonLabel: StringValue.back,
      onButtonPressed: () {
        if (navigateFromMenu) {
          FakeNavigator.menu.pop();
        } else {
          FakeNavigator.root.pop();
        }
      },
    );
  }
}
