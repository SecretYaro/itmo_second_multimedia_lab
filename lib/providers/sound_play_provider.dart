import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

final soundOnProvider = StateProvider<bool>((ref) {
  return false;
});

const audioString = "assets/track.mp3";

final playerProvider = Provider<AudioPlayer>((ref) {
  ref.onDispose(() {
    ref.state.dispose();
  });
  ref.listen<bool>(soundOnProvider, (previous, soundOn) {
    if (!soundOn) {
      ref.state.pause();
    } else {
      ref.state.play();
    }
  });
  return AudioPlayer()
    ..setAsset(audioString)
    ..playingStream.listen((state) {
      ref.read(soundOnProvider.notifier).state = ref.state.playing;
    });
});
