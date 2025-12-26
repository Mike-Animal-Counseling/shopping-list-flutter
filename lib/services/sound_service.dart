import 'package:audioplayers/audioplayers.dart';

class SoundService {
  SoundService() : _player = AudioPlayer();

  final AudioPlayer _player;

  Future<void> playSelect() async {
    await _player.play(AssetSource('sounds/select.wav'), volume: 0.8);
  }

  Future<void> playDeselect() async {
    await _player.play(AssetSource('sounds/deselect.wav'), volume: 0.8);
  }

  Future<void> dispose() async => _player.dispose();
}
