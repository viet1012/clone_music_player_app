import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import 'PositionData.dart';
import 'Song.dart'; // Import Song and SongData
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

  @override
  void initState() {
    _initAudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _initAudioPlayer() async {
    await _audioPlayer.setAsset(SongData.songs[_currentIndex].url);

    _audioPlayer.playerStateStream.listen(
      (state) {
        setState(() async {
          _isPlaying = state.playing;
          // Cập nhật trạng thái phát của từng bài hát trong SongData.songs
          for (int i = 0; i < SongData.songs.length; i++) {
            SongData.songs[i].isCurrentPlaying =
                (i == _currentIndex) && state.playing;
          }

          if (_isPlaying) {
            _controller.repeat();
          } else {
            _controller.stop();
          }

          if (state.processingState == ProcessingState.completed) {
            _controller.stop();
            await _audioPlayer.seek(Duration.zero);
            await _audioPlayer.stop();
            SongData.songs[_currentIndex].isCurrentPlaying = false;
            _isPlaying = false;
            _nextSong();
          }
        });
      },
    );

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _audioPlayer.setVolume(_volume);
  }

  void _playPauseSong(int index) async {
    final isCurrentlyPlaying = _audioPlayer.playing;

    if (_currentIndex != index) {
      // Dừng bài hát hiện tại
      await _audioPlayer.stop();
      // Chọn bài hát mới và phát
      if (SongData.songs[index].url.startsWith('assets')) {
        await _audioPlayer.setAsset(SongData.songs[index].url);
      } else {
        await _audioPlayer.setUrl(SongData.songs[index].url);
      }
      _currentIndex = index;
      _audioPlayer.play();
    } else {
      // Nếu là bài hát đang phát, toggle play/pause
      if (isCurrentlyPlaying) {
        _audioPlayer.pause();
      } else {
        _audioPlayer.play();
      }
    }

    setState(() {
      _isPlaying = _audioPlayer.playing;
      // Đánh dấu bài hát đang được phát
      SongData.songs.forEach((song) => song.isCurrentPlaying = false);
      SongData.songs[index].isCurrentPlaying = _isPlaying;
      // Nếu đang phát thì repeat controller, ngược lại thì stop
      if (_isPlaying) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    });
  }

  void _nextSong() async {
    final nextIndex = (_currentIndex + 1) % SongData.songs.length;
    if (SongData.songs[nextIndex].url.startsWith('assets')) {
      await _audioPlayer.setAsset(SongData.songs[nextIndex].url);
    } else {
      await _audioPlayer.setUrl(SongData.songs[nextIndex].url);
    }
    _currentIndex = nextIndex;
    _audioPlayer.play();
    setState(() {
      _isPlaying = true;
      SongData.songs.forEach((song) => song.isCurrentPlaying = false);
      SongData.songs[nextIndex].isCurrentPlaying = true;
    });
    _controller.repeat();

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => SongDetailScreen(
    //       title: SongData.songs[nextIndex].title,
    //       author: SongData.songs[nextIndex].author,
    //       imageUrl: SongData.songs[nextIndex].image,
    //       audioPlayer: _audioPlayer,
    //       currentIndex: nextIndex,
    //       isPlaying: _isPlaying,
    //       controller: _controller,
    //       playPauseSong: () => _playPauseSong(nextIndex),
    //       lyrics: SongData.songs[nextIndex].lyrics,
    //       isDetail: true,
    //       onNextSong: _nextSong,
    //       shouldCloseOnComplete: true,
    //     ),
    //   ),
    // );
  }

  void _previousSong() async {
    final previousIndex =
        (_currentIndex - 1 + SongData.songs.length) % SongData.songs.length;
    if (SongData.songs[previousIndex].url.startsWith('assets')) {
      await _audioPlayer.setAsset(SongData.songs[previousIndex].url);
    } else {
      await _audioPlayer.setUrl(SongData.songs[previousIndex].url);
    }
    _currentIndex = previousIndex;
    _audioPlayer.play();
    setState(() {
      _isPlaying = true;
      SongData.songs.forEach((song) => song.isCurrentPlaying = false);
      SongData.songs[previousIndex].isCurrentPlaying = true;
    });
    _controller.repeat();
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

  void _onSeek(Duration duration) async {
    if (_isPlaying) {
      await _audioPlayer.seek(duration, index: _currentIndex);
    } else {
      // Nếu không phát, chỉ cần chuyển bài hát mà không phải tua lại
      _nextSong();
    }
  }

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
        actions: [
          IconButton(
            icon: Icon(Icons.volume_up),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Adjust Volume',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Slider(
                        value: _volume,
                        onChanged: _setVolume,
                        min: 0.0,
                        max: 1.0,
                        divisions: 10,
                        label: '$_volume',
                      ),
                    ],
                  ),
                ),
              );
            },
            color: Colors.white,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/V.jpg"),
            fit: BoxFit.cover,
            opacity: 0.8,
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1DB954).withOpacity(1),
              Colors.black.withOpacity(1),
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: SongData.songs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (_isPlaying && _currentIndex == index) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SongDetailScreen(
                              title: SongData.songs[index].title,
                              author: SongData.songs[index].author,
                              imageUrl: SongData.songs[index].image,
                              audioPlayer: _audioPlayer,
                              currentIndex: _currentIndex,
                              isPlaying: _isPlaying,
                              controller: _controller,
                              playPauseSong: () => _playPauseSong(index),
                              lyrics: SongData.songs[index].lyrics,
                              isDetail: true,
                              onNextSong: _nextSong,
                              shouldCloseOnComplete: true,
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: SongData.songs[index].isCurrentPlaying
                            ? Colors.pink.withOpacity(0.2)
                            : Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: SizedBox(
                          width: 65.0,
                          height: 65.0,
                          child: ClipOval(
                            child: Hero(
                              tag: 'songImage$index',
                              child: CachedNetworkImage(
                                imageUrl: SongData.songs[index].image,
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
                          SongData.songs[index].title,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          SongData.songs[index].author,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            _isPlaying && _currentIndex == index
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 40,
                          ),
                          onPressed: () => _playPauseSong(index),
                        ),
                      ),
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

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ProgressBar(
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
                        onSeek: _onSeek,
                        // onSeek: (duration) async {
                        //   await _audioPlayer.seek(duration,
                        //       index: _currentIndex);
                        //   setState(
                        //     () {
                        //       _controller.value = duration.inSeconds.toDouble();
                        //     },
                        //   );
                        // },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.skip_previous),
                            onPressed: _previousSong,
                            color: Colors.white,
                          ),
                          IconButton(
                            icon: _isPlaying
                                ? const Icon(Icons.pause)
                                : const Icon(Icons.play_arrow),
                            onPressed: () {
                              _playPauseSong(_currentIndex);
                            },
                            color: Colors.white,
                          ),
                          IconButton(
                            icon: const Icon(Icons.skip_next),
                            onPressed: _nextSong,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
