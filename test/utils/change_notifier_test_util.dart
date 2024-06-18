import 'dart:async';
import 'package:flutter/material.dart';

Future<int> changeNotifierTest<T>({
  required T notifier,
  FutureOr<void> Function()? setUp,
  required FutureOr<void> Function() act,
  required ValueChanged<int> onNotify,
  FutureOr<void> Function()? tearDown,
}) async {
  if (notifier is! ChangeNotifier) {
    throw ArgumentError('notifier must be a ChangeNotifier class');
  }

  int notifierCounter = 0;

  void notifierListener() {
    notifierCounter++;
    onNotify(notifierCounter);
  }

  if (setUp != null) await setUp();

  notifier.addListener(notifierListener);
  await act();
  notifier.removeListener(notifierListener);

  if (tearDown != null) await tearDown();

  return notifierCounter;
}
