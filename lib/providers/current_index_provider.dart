import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itmo_second_multimedia_lab/providers/assets_provider.dart';

final currentIndexProvider =
    StateNotifierProvider<CurrentIndexNotifier, int>((ref) {
  final assets = ref.watch(assetsProvider);
  return CurrentIndexNotifier(ref, assets.length - 1);
});

class CurrentIndexNotifier extends StateNotifier<int> {
  CurrentIndexNotifier(this.ref, this._maxIndex) : super(0);
  final StateNotifierProviderRef<CurrentIndexNotifier, int> ref;
  final int _maxIndex;

  void plus() {
    if (state + 1 > _maxIndex) {
      state = 0;
    } else {
      state++;
    }
  }

  void minus() {
    if (state - 1 < 0) {
      state = _maxIndex;
    } else {
      state--;
    }
  }
}
