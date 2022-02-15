import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itmo_second_multimedia_lab/providers/auto_scroll_provider.dart';
import 'package:itmo_second_multimedia_lab/providers/current_index_provider.dart';
import 'package:itmo_second_multimedia_lab/providers/sound_play_provider.dart';
import 'package:itmo_second_multimedia_lab/widgets/images_line_widget.dart';
import 'package:itmo_second_multimedia_lab/widgets/main_image_widget.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(playerProvider);
    ref.watch(autoScrollProvider);
    final textController = useTextEditingController();
    if (textController.text.isEmpty) {
      textController.text = ref.watch(timeToScrollProvider).toString();
    }

    final isPlayAuto = !ref.watch(pauseProvider);
    final isAudioPlaying = ref.watch(soundOnProvider);
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: Stack(
              children: [
                const Positioned.fill(child: MainImageWidget()),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () =>
                          ref.read(currentIndexProvider.notifier).plus(),
                      icon: const Icon(Icons.chevron_left)),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () =>
                          ref.read(currentIndexProvider.notifier).minus(),
                      icon: const Icon(Icons.chevron_right)),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FloatingActionButton(
                        onPressed: () => ref
                            .read(pauseProvider.notifier)
                            .state = (isPlayAuto),
                        child:
                            Icon(isPlayAuto ? Icons.pause : Icons.play_arrow),
                      ),
                      FloatingActionButton(
                        onPressed: () => ref
                            .read(soundOnProvider.notifier)
                            .state = (!isAudioPlaying),
                        child: Icon(isAudioPlaying
                            ? Icons.volume_off
                            : Icons.volume_up_rounded),
                      ),
                      SizedBox(
                        width: 100,
                        child: Material(
                          child: TextFormField(
                            controller: textController,
                            maxLength: 5,
                            validator: (text) {
                              final number = int.tryParse(text ?? '');
                              if (number == null) {
                                return "Error";
                              }
                              return null;
                            },
                            onChanged: (text) {
                              ref.read(timeToScrollProvider.notifier).state =
                                  int.parse(text);
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            flex: 3,
          ),
          const Flexible(child: ImagesLineWidget())
        ],
      ),
    );
  }
}
