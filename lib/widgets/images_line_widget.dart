import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itmo_second_multimedia_lab/providers/assets_provider.dart';
import 'package:itmo_second_multimedia_lab/providers/current_index_provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

const imageCardWidth = 400.0;

class ImagesLineWidget extends HookConsumerWidget {
  const ImagesLineWidget({Key? key}) : super(key: key);

  Widget _itemBuilder(
    BuildContext context,
    int index,
    List<String> images,
    AutoScrollController controller,
  ) {
    return AutoScrollTag(
      controller: controller,
      key: ValueKey(images[index]),
      index: index,
      child: Image.asset(
        'images/${images[index]}',
        width: imageCardWidth,
        fit: BoxFit.cover,
      ),
    );
  }

  AutoScrollController useAutoScrollController<T>() {
    final state = useState<AutoScrollController>(AutoScrollController());
    // print(debugLabel + ": " + initialState);
    return state.value;
  }

  @override
  Widget build(BuildContext context, ref) {
    final images = ref.watch(assetsProvider).values.toList();
    final scrollController = (useAutoScrollController());

    ref.listen<int>(currentIndexProvider, (_, next) {
      scrollController.scrollToIndex(next);
    });
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: PointerDeviceKind.values.toSet(),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        controller: scrollController,
        itemCount: images.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => _itemBuilder(
          context,
          index,
          images,
          scrollController,
        ),
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 16),
      ),
    );
  }
}
