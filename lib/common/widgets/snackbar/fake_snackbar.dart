import 'package:flutter/material.dart';
import 'package:fake_store_ds/fake_store_ds.dart';

abstract class FakeSnackBar {
  static void showError(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: FakeTextMedium(
          message,
          color: Theme.of(context).colorScheme.onError,
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
