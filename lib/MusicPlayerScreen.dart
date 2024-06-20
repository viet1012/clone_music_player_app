import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import 'PositionData.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  int _currentIndex = 0;
  List<Map<String, String>> _songs = [
    {
      'title': 'Song 1',
      'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'title': 'Song 2',
      'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'title': 'Song 3',
      'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
      'image': 'https://via.placeholder.com/150'
    },
  ];
  @override
  void initState() {
    super.initState();
    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        _isPlaying = state.playing;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playPauseSong(int index) async {
    if (_currentIndex != index || !_isPlaying) {
      await _audioPlayer.setUrl(_songs[index]['url']!);
      _audioPlayer.play();
      setState(() {
        _currentIndex = index;
        _isPlaying = true;
      });
    } else {
      _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (
          position,
          bufferedPosition,
          duration,
        ) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
