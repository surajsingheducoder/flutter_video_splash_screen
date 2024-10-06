import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'home_screen.dart';

class VideoSplashScreen extends StatefulWidget {
  const VideoSplashScreen({super.key});

  @override
  _VideoSplashScreenState createState() => _VideoSplashScreenState();
}

class _VideoSplashScreenState extends State<VideoSplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/krijaar_video.mp4')
      ..initialize().then((_) {
        setState(() {}); // Refresh the screen when the video is initialized
        _controller.setVolume(0.0);  // Mute the video
        _controller.play();  // Auto-play the video
        _controller.setLooping(false);  // Looping off
      });

    // Navigate to the next screen after the video ends
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        // Video completed, navigate to the next screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),  // Replace HomeScreen with your target screen
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],  // Replace with your desired colors
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Video player
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                : const CircularProgressIndicator(),  // Show a loading indicator while the video is initializing
          ),
        ],
      ),
    );
  }
}
