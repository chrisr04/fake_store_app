import 'package:fake_store_app/common/values/values.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FakeErrorPage(
      appBarTitle: StringValue.error,
      imagePath: AssetValue.notFoundIllustrationPng,
      error: StringValue.routeNotFound,
      description: StringValue.pleaseCheckThePath,
      onButtonPressed: () => Navigator.of(context).pop(),
      buttonLabel: StringValue.back,
    );
  }
}
