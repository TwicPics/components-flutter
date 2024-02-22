// ignore_for_file: must_be_immutable, constant_identifier_names
import 'package:flutter/material.dart';
import 'package:twicpics_components/src/custom_image.dart';
import 'package:twicpics_components/src/types.dart' as twic_types;
import 'package:video_player/video_player.dart';

class CustomVideo extends StatefulWidget {
  Alignment alignment;
  BoxFit fit;
  final ValueChanged<bool> onLoaded;
  twic_types.Urls urls;
  twic_types.Size viewSize;
  CustomVideo({
    super.key,
    required this.alignment,
    required this.fit,
    required this.onLoaded,
    required this.urls,
    required this.viewSize,
  });
  @override
  State<CustomVideo> createState() => _CustomVideoState();
}

class _CustomVideoState extends State<CustomVideo> {
  VideoPlayerController? _controller;

  Future<void> startVideoPlayer() async {
    if (_controller != null) {
      await _controller!.dispose();
    }
    if (widget.urls.media != null) {
      _controller = VideoPlayerController.networkUrl(
          Uri.parse(widget.urls.media!),
          videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
        ..initialize().then((_) {
          setState(() {
            widget.onLoaded(true);
            _controller!.setVolume(0);
            _controller!.setLooping(true);
            _controller!.play();
          });
        });
    }
  }

  @override
  void didChangeDependencies() {
    if (widget.urls.media != null) {
      startVideoPlayer();
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(CustomVideo oldWidget) {
    if (oldWidget.urls.media != widget.urls.media) {
      startVideoPlayer();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      crossFadeState: (_controller != null && _controller!.value.isInitialized)
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 1),
      reverseDuration: const Duration(milliseconds: 250),
      firstCurve: Curves.easeIn,
      secondCurve: Curves.easeOut,
      layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) =>
          Stack(
        children: [
          Positioned(key: bottomChildKey, child: bottomChild),
          Positioned(key: topChildKey, child: topChild)
        ],
      ),
      firstChild: SizedBox(
          height: widget.viewSize.height!,
          width: widget.viewSize.width,
          child: FittedBox(
            fit: widget.fit,
            alignment: widget.alignment,
            child: SizedBox(
                width: _controller!.value.size.width,
                height: _controller!.value.size.height,
                child: VideoPlayer(_controller!)),
          )),
      secondChild: SizedBox(
        height: widget.viewSize.height!,
        width: widget.viewSize.width,
        child: CustomImage(
          alignment: widget.alignment,
          fit: widget.fit,
          url: widget.urls.poster,
          onLoaded: (loaded) => {
            setState(() {
              widget.onLoaded(true);
            })
          },
        ),
      ),
    );
  }
}
