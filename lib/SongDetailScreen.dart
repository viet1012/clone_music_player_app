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
  // final bool isCurrentPlaying;
  const SongDetailScreen({
    required this.title,
    required this.imageUrl,
    required this.audioPlayer,
    required this.isPlaying,
    required this.currentIndex,
    required this.controller,
    required this.playPauseSong,
    required this.author,
    required this.lyrics,
    this.isDetail = false,
    // required this.isCurrentPlaying,
  });

  @override
  State<SongDetailScreen> createState() => _SongDetailScreenState();
}

class _SongDetailScreenState extends State<SongDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _lyricsAnimationController;
  late bool _isPlaying;
  late Duration _currentPosition;

  @override
  void initState() {
    super.initState();
    _isPlaying = widget.isPlaying;
    _currentPosition = Duration.zero;
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _lyricsAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    if (_isPlaying && widget.currentIndex == 0) {
      _rotationController.repeat();
      _startLyricsAnimation();
    }
  }

  @override
  void didUpdateWidget(covariant SongDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying != oldWidget.isPlaying ||
        widget.currentIndex != oldWidget.currentIndex) {
      setState(() {
        _isPlaying = widget.isPlaying;
      });
      if (_isPlaying && widget.currentIndex == 0) {
        _rotationController.repeat();
        _startLyricsAnimation();
      } else {
        _rotationController.stop();
        _lyricsAnimationController.reset();
      }
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _lyricsAnimationController.dispose();
    super.dispose();
  }

  void _handlePlayPause() async {
    if (_isPlaying) {
      _currentPosition = await widget.audioPlayer.position;
      await widget.audioPlayer.pause();
      _rotationController.stop();
      _lyricsAnimationController.stop();
    } else {
      await widget.audioPlayer.seek(_currentPosition);
      await widget.audioPlayer.play();
      _rotationController.repeat();
      _lyricsAnimationController.forward();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _startLyricsAnimation() {
    _lyricsAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          height: MediaQuery.of(context).size.width * (9 / 16),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.pink, Colors.orange],
            ),
          ),
        ),
        title: Text(
          widget.author,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.purple.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            const SizedBox(height: 16.0),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 3.0,
                    color: Colors.black38,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ProgressBar(
                    progress: position,
                    buffered: positionData?.bufferedPosition ?? Duration.zero,
                    total: duration,
                    onSeek: widget.audioPlayer.seek,
                    progressBarColor: Colors.white,
                    baseBarColor: Colors.white.withOpacity(0.24),
                    bufferedBarColor: Colors.white.withOpacity(0.24),
                    thumbColor: Colors.white,
                    barHeight: 5.0,
                    thumbRadius: 7.0,
                  ),
                );
              },
            ),
            const SizedBox(height: 24.0),
            IconButton(
              onPressed: _handlePlayPause,
              icon: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                size: 48.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6.0),
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
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
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
