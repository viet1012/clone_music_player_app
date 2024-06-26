import 'dart:async';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import 'PositionData.dart';

class SongDetailScreen extends StatefulWidget {
  final String title;
  final String author;
  final String imageUrl;
  final AudioPlayer audioPlayer;
  final bool isPlaying;
  final int currentIndex;
  final AnimationController controller;
  final VoidCallback playPauseSong;
  final String lyrics;
  final bool isDetail;
  final Function onNextSong; // Callback to notify when song ends
  final bool shouldCloseOnComplete;

  const SongDetailScreen({
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.audioPlayer,
    required this.isPlaying,
    required this.currentIndex,
    required this.controller,
    required this.playPauseSong,
    required this.lyrics,
    required this.onNextSong,
    this.isDetail = false,
    this.shouldCloseOnComplete = false,
  });

  @override
  State<SongDetailScreen> createState() => _SongDetailScreenState();
}

class _SongDetailScreenState extends State<SongDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _lyricsAnimationController;
  late bool _isPlaying;
  late bool _isCompleted; // Track if the song has completed
  late Duration _currentPosition;
  late Duration _songDuration; // Track the duration of the song
  late StreamSubscription<Duration> _positionSubscription;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = widget.audioPlayer;
    _isPlaying = widget.isPlaying;
    _isCompleted = false;
    _currentPosition = Duration.zero;
    _songDuration = Duration.zero;
    _positionSubscription =
        widget.audioPlayer.positionStream.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _lyricsAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    if (_isPlaying) {
      _rotationController.repeat();
      _startLyricsAnimation();
    }

    widget.audioPlayer.positionStream.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });

    widget.audioPlayer.durationStream.listen((duration) {
      setState(() {
        _songDuration = duration ?? Duration.zero;
      });
    });

    widget.audioPlayer.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        setState(() {
          _isPlaying = false;
          _isCompleted = true;
          _currentPosition = _songDuration;
        });
        _rotationController.stop();
        _lyricsAnimationController.stop();
        if (widget.shouldCloseOnComplete) {
          Navigator.of(context).pop();
        } else {
          widget.onNextSong();
        }
      }
    });
  }

  @override
  void didUpdateWidget(covariant SongDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying != oldWidget.isPlaying ||
        widget.currentIndex != oldWidget.currentIndex) {
      setState(() {
        _isPlaying = widget.isPlaying;
        _isCompleted = false;
      });
      if (_isPlaying) {
        if (!_rotationController.isAnimating) {
          _rotationController.repeat();
        }
        _startLyricsAnimation();
      } else {
        _rotationController
            .stop(); // Không huỷ để có thể tiếp tục từ vị trí hiện tại
        _lyricsAnimationController.stop();
      }
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _lyricsAnimationController.dispose();
    _positionSubscription.cancel();
    super.dispose();
  }

  void _handlePlayPause() async {
    bool newIsPlaying = !_isPlaying; // Lấy trạng thái mới của isPlaying

    if (newIsPlaying) {
      await widget.audioPlayer.play();
      if (!_rotationController.isAnimating) {
        _rotationController.repeat();
      }
      _startLyricsAnimation();
    } else {
      await widget.audioPlayer.pause();
      _rotationController.stop(); // Chỉ cần stop, không cần đặt canceled: false
      _lyricsAnimationController.stop();
    }

    setState(() {
      _isPlaying = newIsPlaying; // Cập nhật trạng thái của isPlaying
    });
  }

  void _startLyricsAnimation() {
    _lyricsAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87, // Màu nền đen
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.author,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Màu chữ trắng
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
            color: Colors.white, // Màu icon trắng
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
            color: Colors.white, // Màu icon trắng
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xFF1DB954)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200.0,
                  height: 200.0,
                  child: ClipOval(
                    child: RotationTransition(
                      turns: _rotationController,
                      child: CachedNetworkImage(
                        imageUrl: widget.imageUrl,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _handlePlayPause,
                  child: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 64.0,
                    color: Colors.white.withOpacity(0.8), // Màu icon trắng
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Màu chữ trắng
                shadows: [
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 3.0,
                    color: Colors.black38,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            StreamBuilder<PositionData>(
              stream: Rx.combineLatest3(
                widget.audioPlayer.positionStream,
                widget.audioPlayer.bufferedPositionStream,
                widget.audioPlayer.durationStream,
                (position, bufferedPosition, duration) => PositionData(
                    position, bufferedPosition, duration ?? Duration.zero),
              ),
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                final duration = positionData?.duration ?? Duration.zero;
                final position = positionData?.position ?? Duration.zero;

                Duration currentPosition =
                    _isCompleted ? _songDuration : position;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ProgressBar(
                    progress: currentPosition,
                    buffered: positionData?.bufferedPosition ?? Duration.zero,
                    total: duration,
                    onSeek: widget.audioPlayer.seek,
                    progressBarColor: Colors.white,
                    baseBarColor: Colors.white.withOpacity(0.24),
                    bufferedBarColor: Colors.white.withOpacity(0.24),
                    barHeight: 5.0,
                    thumbColor: Colors.white,
                    thumbRadius: 7.0,
                    timeLabelTextStyle: TextStyle(
                      color: Colors.white, // Màu chữ trắng
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 24.0),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: AnimatedBuilder(
                  animation: _lyricsAnimationController,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.translate(
                      offset: Offset(
                        MediaQuery.of(context).size.width *
                            (1 - _lyricsAnimationController.value),
                        0.0,
                      ),
                      child: Text(
                        widget.lyrics,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white, // Màu chữ trắng
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
