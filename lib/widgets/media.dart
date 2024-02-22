// ignore_for_file: must_be_immutable, constant_identifier_names
import 'package:flutter/material.dart' hide Image;
import 'package:twicpics_components/src/types.dart';
import 'package:twicpics_components/widgets/image.dart';
import 'package:twicpics_components/widgets/video.dart';

class Media extends StatefulWidget {
  Alignment alignment;
  BoxFit fit;
  MediaType mediaType;
  final ValueChanged<bool> onLoaded;
  Urls urls;
  Size viewSize;
  Media(
      {super.key,
      required this.alignment,
      required this.fit,
      required this.mediaType,
      required this.onLoaded,
      required this.urls,
      required this.viewSize});

  @override
  State<Media> createState() => _MediaState();
}

class _MediaState extends State<Media> {
  @override
  Widget build(BuildContext context) {
    return widget.mediaType == MediaType.image
        ? Image(
            alignment: widget.alignment,
            fit: widget.fit,
            url: widget.urls.media,
            onLoaded: (loaded) {
              widget.onLoaded(loaded);
            },
          )
        : CustomVideo(
            alignment: widget.alignment,
            fit: widget.fit,
            urls: widget.urls,
            onLoaded: (loaded) {
              widget.onLoaded(loaded);
            },
            viewSize: widget.viewSize);
  }
}
