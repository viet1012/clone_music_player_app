import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import 'PositionData.dart';
import 'SongDetailScreen.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({Key? key}) : super(key: key);

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen>
    with TickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  int _currentIndex = 0;
  double _volume = 0.5;
  late AnimationController _controller;

  List<Map<String, dynamic>> _songs = [
    {
      'title': 'Jisoo - Flower',
      'author': 'Jisoo',
      'url': 'assets/audio/Y2meta.app - JISOO - ‘꽃(FLOWER)’ M_V (128 kbps).mp3',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRc9gtzgargQrvVZrLT-7cGQXc6VvM22b4cqQ&s',
      'lyrics': '''
[Intro]
ABC 도레미만큼 착했던 나
그 눈빛이 싹 변했지 어쩌면 이 또한 나니까
''',
      'isCurrentPlaying': false,
    },
    {
      'title': 'BLACKPINK - DDU-DU DDU-DU',
      'author': 'BLACKPINK',
      'url':
          'assets/audio/Y2meta.app - BLACKPINK - ‘뚜두뚜두 (DDU-DU DDU-DU)’ M_V (128 kbps).mp3',
      'image': 'https://i.ytimg.com/vi/IHNzOHi8sJs/maxresdefault.jpg',
      'lyrics': "",
      'isCurrentPlaying': false,
    },
    {
      'title': 'BLACKPINK - Kill This Love',
      'author': 'BLACKPINK',
      'url':
          "assets/audio/Y2meta.app - BLACKPINK - 'Kill This Love' M_V (128 kbps).mp3",
      'image':
          'https://ss-images.saostar.vn/2019/04/07/4920635/blackpink-kill-this-love-mv-2019-billboard-1548.jpg',
      'lyrics': "",
      'isCurrentPlaying': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _initAudioPlayer() {
    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        _isPlaying = state.playing;
        if (_isPlaying) {
          _controller.repeat();
        } else {
          _controller.stop();
        }
      });

      if (state.processingState == ProcessingState.completed) {
        _nextSong(); // Auto play next song when current song completes
      }
    });

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _audioPlayer.setVolume(_volume);
  }

  void _playPauseSong(int index) async {
    final isCurrentlyPlaying = _audioPlayer.playing;

    if (_currentIndex != index) {
      if (_songs[index]['url']!.startsWith('assets')) {
        await _audioPlayer.setAsset(_songs[index]['url']!);
      } else {
        await _audioPlayer.setUrl(_songs[index]['url']!);
      }
      _currentIndex = index;
    }

    if (isCurrentlyPlaying) {
      _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
        _songs[index]['isCurrentPlaying'] = false;
      });
      _controller.stop();
    } else {
      _audioPlayer.play();
      setState(() {
        _isPlaying = true;
        _songs.forEach((song) => song['isCurrentPlaying'] = false);
        _songs[index]['isCurrentPlaying'] = true;
      });
      _controller.repeat();
    }
  }

  void _nextSong() {
    final nextIndex = (_currentIndex + 1) % _songs.length;
    _playPauseSong(nextIndex);
  }

  void _previousSong() {
    final previousIndex = (_currentIndex - 1 + _songs.length) % _songs.length;
    _playPauseSong(previousIndex);
  }

  void _setVolume(double value) {
    setState(() {
      _volume = value;
      _audioPlayer.setVolume(_volume);
    });
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
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.music_note, color: Colors.white),
            SizedBox(width: 8.0),
            Text(
              'Music Player',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black87,
        elevation: 0,
        centerTitle: false,
      ),
      body: Container(
        // color: Colors.black54,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/V.jpg"),
            fit: BoxFit.cover,
            opacity: 0.8,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _songs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SongDetailScreen(
                            title: _songs[index]['title']!,
                            author: _songs[index]['author']!,
                            imageUrl: _songs[index]['image']!,
                            audioPlayer: _audioPlayer,
                            currentIndex: _currentIndex,
                            isPlaying: _isPlaying,
                            controller: _controller,
                            playPauseSong: () => _playPauseSong(index),
                            lyrics: _songs[index]['lyrics']!,
                            isDetail: true,
                          ),
                        ),
                      );
                    },
                    child: TweenAnimationBuilder<Color?>(
                      tween: ColorTween(
                        begin: Colors.white,
                        end: _songs[index]['isCurrentPlaying']
                            ? Colors.pink.withOpacity(0.9)
                            : Colors.white,
                      ),
                      duration: Duration(milliseconds: 500),
                      builder:
                          (BuildContext context, Color? value, Widget? child) {
                        return Container(
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: value,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: SizedBox(
                              width: 60.0,
                              height: 60.0,
                              child: ClipOval(
                                child: Hero(
                                  tag: 'songImage$index',
                                  child: CachedNetworkImage(
                                    imageUrl: _songs[index]['image']!,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              _songs[index]['title']!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(_isPlaying && _currentIndex == index
                                  ? Icons.pause
                                  : Icons.play_arrow),
                              onPressed: () => _playPauseSong(index),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            StreamBuilder<PositionData>(
              stream: _positionDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                final duration = positionData?.duration ?? Duration.zero;
                final position = positionData?.position ?? Duration.zero;

                double progressInSeconds = position.inSeconds.toDouble();
                double totalInSeconds = duration.inSeconds.toDouble();

                if (progressInSeconds > totalInSeconds) {
                  progressInSeconds = totalInSeconds;
                }

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ProgressBar(
                        progress: Duration(
                          seconds: progressInSeconds.toInt(),
                        ),
                        buffered:
                            positionData?.bufferedPosition ?? Duration.zero,
                        total: duration,
                        baseBarColor: Colors.grey,
                        progressBarColor: Colors.pinkAccent,
                        bufferedBarColor: Colors.white70,
                        thumbColor: Colors.pink,
                        barHeight: 8.0,
                        thumbRadius: 8.0,
                        timeLabelTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        onSeek: (duration) async {
                          await _audioPlayer.seek(duration,
                              index: _currentIndex);
                          setState(() {
                            _controller.value = duration.inSeconds.toDouble();
                          });
                        },
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon:
                                Icon(Icons.skip_previous, color: Colors.white),
                            onPressed: _previousSong,
                          ),
                          IconButton(
                            icon: Icon(
                              _isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                            ),
                            onPressed: () => _playPauseSong(_currentIndex),
                          ),
                          IconButton(
                            icon: const Icon(Icons.skip_next,
                                color: Colors.white),
                            onPressed: _nextSong,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.volume_down, color: Colors.white),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Slider(
                              value: _volume,
                              min: 0.0,
                              max: 1.0,
                              onChanged: _setVolume,
                              activeColor: Colors.pinkAccent,
                              inactiveColor: Colors.grey.shade400,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          const Icon(Icons.volume_up, color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
