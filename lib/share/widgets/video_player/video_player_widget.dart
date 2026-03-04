import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// ─────────────────────────────────────────────────────
/// VideoPlayerWidget
/// Play / Pause / Stop / Seek / Fullscreen / Mute
///
/// Usage:
///   VideoPlayerWidget(videoUrl: "https://example.com/video.mp4")
///
/// pubspec.yaml:
///   video_player: ^2.9.2
///   chewie: ^1.8.5
///
/// Android — AndroidManifest.xml:
///   <uses-permission android:name="android.permission.INTERNET"/>
///
/// iOS — Info.plist:
///   <key>NSAppTransportSecurity</key>
///   <dict><key>NSAllowsArbitraryLoads</key><true/></dict>
/// ─────────────────────────────────────────────────────


class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    this.height = 220,
    this.borderRadius = 15,
  });

  final String videoUrl;
  final double height;
  final double borderRadius;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;

  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    if (widget.videoUrl.isEmpty) {
      setState(() => _hasError = true);
      return;
    }

    try {
      _videoController = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );

      await _videoController!.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        autoPlay: false,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        aspectRatio: _videoController!.value.aspectRatio,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.blue,
          handleColor: Colors.blueAccent,
          backgroundColor: Colors.grey.shade800,
          bufferedColor: Colors.lightBlue.shade100,
        ),
        placeholder: Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
        errorBuilder: (context, errorMessage) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.white, size: 40),
              const SizedBox(height: 8),
              Text(
                "Video load failed",
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ],
          ),
        ),
      );

      if (mounted) setState(() => _isInitialized = true);
    } catch (e) {
      debugPrint("Video init error: $e");
      if (mounted) setState(() => _hasError = true);
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Error state
    if (_hasError || widget.videoUrl.isEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Container(
          height: widget.height,
          width: double.infinity,
          color: Colors.black12,
          child: const Center(
            child: Icon(Icons.videocam_off, size: 48, color: Colors.grey),
          ),
        ),
      );
    }

    /// Loading state
    if (!_isInitialized) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Container(
          height: widget.height,
          width: double.infinity,
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      );
    }

    /// Player ready
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: SizedBox(
        height: widget.height,
        width: double.infinity,
        child: Chewie(controller: _chewieController!),
      ),
    );
  }
}