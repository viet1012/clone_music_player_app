import 'package:clone_music_player_app/MusicPlayerScreen.dart';
import 'package:flutter/material.dart';

import 'AnimatedLogo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool _visible; // Biến để điều khiển hiển thị của Splash Screen

  @override
  void initState() {
    super.initState();
    _visible = false;

    // Đợi 2 giây rồi bắt đầu hiển thị fade in
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _visible = true;
      });

      // Sau 5 giây, chuyển sang màn hình Login
      Future.delayed(Duration(seconds: 5), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MusicPlayerScreen()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: const Duration(seconds: 2), // Thời gian fade in
          curve: Curves.easeIn,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedLogo(
                width: 200,
                height: 200,
              ), // Đây có thể là logo hoặc hình ảnh khác của bạn
              SizedBox(height: 20),
              Text(
                'Welcome to V',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
