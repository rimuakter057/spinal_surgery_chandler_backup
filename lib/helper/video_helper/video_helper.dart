import 'package:chewie/chewie.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoHelper {
  VideoPlayerController? videoController;
  ChewieController? chewieController;
  bool isVideoInitialized = false;
  bool isVideoLoading = false;

  String formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "${d.inHours > 0 ? '${d.inHours}:' : ''}$minutes:$seconds";
  }

  Future<void> initVideo({
    required String videoUrl,
    required VoidCallback onStateChanged,
  }) async {
    if (isVideoLoading || isVideoInitialized) return;

    isVideoLoading = true;
    onStateChanged();

    try {
      videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      await videoController!.initialize();

      final videoRatio = videoController!.value.aspectRatio;
      final duration = videoController!.value.duration;
      debugPrint("🎬 aspectRatio: $videoRatio");
      debugPrint("⏱️ duration: ${duration.inSeconds}s");

      chewieController = ChewieController(
        videoPlayerController: videoController!,
        autoPlay: true,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        aspectRatio: videoRatio,
        allowPlaybackSpeedChanging: true,
        customControls: const MaterialControls(),
        materialProgressColors: ChewieProgressColors(
          playedColor: AppColors.primaryColor,
          handleColor: AppColors.primaryColor,
          bufferedColor: AppColors.primaryColor.withOpacity(0.3),
          backgroundColor: Colors.white24,
        ),
        placeholder: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );

      // ✅ position + duration track
      videoController!.addListener(() {
        final position = videoController!.value.position;
        final total = videoController!.value.duration;
        if (total.inSeconds > 0) {
          final percent =
          (position.inSeconds / total.inSeconds * 100).toStringAsFixed(0);
          debugPrint(
            "👁️ ${formatDuration(position)} / ${formatDuration(total)} ($percent%)",
          );
        }
      });

      isVideoInitialized = true;
      isVideoLoading = false;
      onStateChanged();
    } catch (e) {
      debugPrint("❌ Video init error: $e");
      isVideoLoading = false;
      onStateChanged();
    }
  }

  void dispose() {
    videoController?.dispose();
    chewieController?.dispose();
  }
}