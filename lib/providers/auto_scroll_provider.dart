import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itmo_second_multimedia_lab/providers/current_index_provider.dart';

final autoScrollProvider = Provider<Timer?>((ref) {
  final isPaused = ref.watch(pauseProvider);
  final millis = ref.watch(timeToScrollProvider);
  ref.onDispose(() {
    ref.state?.cancel();
  });
  if (isPaused) {
    return null;
  }
  return Timer.periodic(Duration(milliseconds: millis), (timer) {
    ref.read(currentIndexProvider.notifier).plus();
  });
});

final pauseProvider = StateProvider<bool>((ref) {
  return false;
});



///millis
const defaultTimeToScroll = 2000;

final timeToScrollProvider = StateProvider<int>((ref) {
  return defaultTimeToScroll;
});
