import 'package:flutter/material.dart';

class LoadingSpinner extends Center {
  const LoadingSpinner({
    super.key = defaultKey,
    super.child = const CircularProgressIndicator(),
  });
  static const Key defaultKey = Key('spinkit');
}
