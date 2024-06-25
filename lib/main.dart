import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

import 'MusicPlayerScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AudioServiceWidget(child: const MusicPlayerScreen()),
    );
  }
}
