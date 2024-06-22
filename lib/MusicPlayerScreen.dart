import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import 'PositionData.dart';
import 'SongDetailScreen.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

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

[Verse 1]
난 파란 나비처럼 날아가
잡지 못한 건 다 네 몫이니까
활짝 꽃피웠던 시간도 이제 모두
내겐 Lie, lie, lie

[Chorus]
붉게 타버려진 너와 나
난 괜찮아 넌 괜찮을까
구름 한 점 없이 예쁜 날
꽃향기만 남기고 갔단다
꽃향기만 남기고 갔단다

[Post-Chorus]
You and me 미칠 듯이 뜨거웠지만
처참하게 짓밟혀진 내 하나뿐인 라일락

[Verse 2]
난 하얀 꽃잎처럼 날아가
잡지 않은 것은 너니까
살랑살랑 부는 바람에 이끌려
봄은 오지만 우린 Bye, bye, bye

[Chorus]
붉게 타버려진 너와 나
난 괜찮아 넌 괜찮을까
구름 한 점 없이 예쁜 날
꽃향기만 남기고 갔단다
꽃향기만 남기고 갔단다

[Bridge]
이젠 안녕 Goodbye
뒤는 절대 안 봐
미련이란 이름의 잎새 하나
봄비에 너에게서 떨어져
꽃향기만 남아

[Outro]
꽃향기만 남기고 갔단다
''',
      'isCurrentPlaying':
          false, // Thêm thuộc tính này để theo dõi trạng thái phát
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
    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        _isPlaying = state.playing;
        if (_isPlaying) {
          _controller.repeat();
        } else {
          _controller.stop();
        }
      });
    });

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _audioPlayer.setVolume(_volume);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _playPauseSong(int index) async {
    if (_currentIndex != index || !_isPlaying) {
      if (_songs[index]['url']!.startsWith('assets')) {
        await _audioPlayer.setAsset(_songs[index]['url']!);
      } else {
        await _audioPlayer.setUrl(_songs[index]['url']!);
      }

      _audioPlayer.play();
      setState(() {
        _currentIndex = index;
        _isPlaying = true;
        _songs.forEach((song) => song['isCurrentPlaying'] = false);
        _songs[index]['isCurrentPlaying'] = true;
      });
      _controller.repeat();
    } else {
      _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
        _songs[index]['isCurrentPlaying'] = false;
      });
      _controller.stop();
    }

    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          _isPlaying = false;
          _songs[index]['isCurrentPlaying'] = false;
        });
        _controller.stop();
      }
    });
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
        backgroundColor: Colors.black87, // Đổi màu nền của AppBar
        elevation: 0,
        centerTitle: false,
      ),
      body: Container(
        color: Colors.black54, // Thay đổi màu nền chính
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
                            ? Colors.blue.withOpacity(0.3)
                            : Colors.white,
                      ),
                      duration: Duration(milliseconds: 500),
                      builder:
                          (BuildContext context, Color? value, Widget? child) {
                        return Container(
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: _songs[index]['isCurrentPlaying']
                                ? Colors.blue.withOpacity(0.3)
                                : Colors.white,
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
                                        Icon(Icons.error),
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

                if (positionData != null) {
                  _controller.value =
                      positionData.position.inSeconds.toDouble();
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      ProgressBar(
                        progress: position,
                        buffered:
                            positionData?.bufferedPosition ?? Duration.zero,
                        total: duration,
                        onSeek: (duration) {
                          _audioPlayer.seek(duration);
                          setState(() {
                            _controller.value = duration.inSeconds.toDouble();
                          });
                        },
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.volume_down),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Slider(
                              value: _volume,
                              min: 0.0,
                              max: 1.0,
                              onChanged: _setVolume,
                              activeColor: Theme.of(context).primaryColor,
                              inactiveColor: Colors.grey.shade400,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Icon(Icons.volume_up),
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
