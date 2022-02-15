import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itmo_second_multimedia_lab/providers/assets_provider.dart';
import 'package:itmo_second_multimedia_lab/providers/current_index_provider.dart';

class MainImageWidget extends HookConsumerWidget {
  const MainImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(assetsProvider);
    final index = ref.watch(currentIndexProvider);
    final image = images.values.toList()[index];
    return AnimatedSwitcher(
      key: ValueKey(image),
      duration: kThemeAnimationDuration,
      child: Column(
        children: [
          Flexible(
            child: Image.asset('images/$image', fit: BoxFit.fitHeight),
          ),
          Text(images.keys.toList()[index]),
        ],
      ),
    );
  }
}
