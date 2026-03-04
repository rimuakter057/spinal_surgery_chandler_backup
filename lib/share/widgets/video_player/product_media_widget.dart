import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class ProductMediaWidget extends StatelessWidget {
  final String videoUrl;
  final String brochureUrl;
  final Widget thumbnail;
  final Widget downloadUi;

  const ProductMediaWidget({
    super.key,
    required this.videoUrl,
    required this.brochureUrl,
    required this.thumbnail,
    required this.downloadUi,
  });

  /// ---------------- VIDEO DIALOG ----------------
  void _openVideo(BuildContext context) {
    if (videoUrl.isEmpty) return;

    showDialog(
      context: context,
      builder: (_) {
        return _VideoDialog(videoUrl: videoUrl);
      },
    );
  }

  /// ---------------- BROCHURE OPEN ----------------
  Future<void> _openBrochure() async {
    if (brochureUrl.isEmpty) return;

    final Uri uri = Uri.parse(brochureUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        /// 🔥 VIDEO
        GestureDetector(
          onTap: () => _openVideo(context),
          child: thumbnail,
        ),

        /// 🔥 DOWNLOAD
        if (brochureUrl.isNotEmpty)
          GestureDetector(
            onTap: _openBrochure,
            child: downloadUi,
          ),
      ],
    );
  }
}

/// ================= VIDEO DIALOG =================

class _VideoDialog extends StatefulWidget {
  final String videoUrl;

  const _VideoDialog({required this.videoUrl});

  @override
  State<_VideoDialog> createState() => _VideoDialogState();
}

class _VideoDialogState extends State<_VideoDialog> {
  late VideoPlayerController _controller;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        _chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: true,
          looping: false,
        );
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: _chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized
            ? Chewie(controller: _chewieController!)
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}