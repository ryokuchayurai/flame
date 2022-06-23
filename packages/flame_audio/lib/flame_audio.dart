import 'package:audioplayers/audioplayers.dart';

import 'package:flame_audio/bgm.dart';

/// This utility class holds static references to some global audio objects.
///
/// You can use as a helper to very simply play a sound or a background music.
/// Alternatively you can create your own instances and control them yourself.
class FlameAudio {
  /// Access a shared instance of the [AudioCache] class.
  static AudioCache audioCache = AudioCache(prefix: 'assets/audio/');

  /// Plays a single run of the given [file], with a given [volume].
  static Future<AudioPlayer> play(String file, {double volume = 1.0}) async {
    // return audioCache.play(file, volume: volume, mode: PlayerMode.LOW_LATENCY);
    final uri = await audioCache.load(file);
    final player = AudioPlayer();
    player.setPlayerMode(PlayerMode.lowLatency);
    await player.play(
      AssetSource(uri.path),
      volume: volume,
    );
    return player;
  }

  /// Plays, and keeps looping the given [file].
  static Future<AudioPlayer> loop(String file, {double volume = 1.0}) async {
    // return audioCache.loop(file, volume: volume, mode: PlayerMode.LOW_LATENCY);
    final uri = await audioCache.load(file);
    final player = AudioPlayer();
    player.setPlayerMode(PlayerMode.lowLatency);
    player.setReleaseMode(ReleaseMode.loop);
    await player.play(
      AssetSource(uri.path),
      volume: volume,
    );
    return player;
  }

  /// Plays a single run of the given file [file]
  /// This method supports long audio files
  static Future<AudioPlayer> playLongAudio(String file, {double volume = 1.0}) async {
    // return audioCache.play(file, volume: volume);
    final uri = await audioCache.load(file);
    final player = AudioPlayer();
    await player.play(
      AssetSource(uri.path),
      volume: volume,
    );
    return player;
  }

  /// Plays, and keep looping the given [file]
  /// This method supports long audio files
  ///
  /// NOTE: Length audio files on Android have an audio gap between loop
  /// iterations, this happens due to limitations on Android's native media
  /// player features. If you need a gapless loop, prefer the loop method.
  static Future<AudioPlayer> loopLongAudio(String file, {double volume = 1.0}) async {
    // return audioCache.loop(file, volume: volume);
    final uri = await audioCache.load(file);
    final player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.loop);
    await player.play(
      AssetSource(uri.path),
      volume: volume,
    );
    return player;
  }

  /// Access a shared instance of the [Bgm] class.
  ///
  /// This will use the same global audio cache from [FlameAudio].
  static late final Bgm bgm = Bgm(audioCache: audioCache);
}
