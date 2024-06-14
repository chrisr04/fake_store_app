import 'package:fake_store_app/common/values/values.dart';
import 'package:flutter/material.dart';
import 'package:fake_store_ds/fake_store_ds.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    super.key,
    required this.error,
  });

  final String error;

  @override
  Widget build(BuildContext context) {
    return FakeErrorTemplate(
      imagePath: AssetValue.errorIllustrationPng,
      error: error,
    );
  }
}
