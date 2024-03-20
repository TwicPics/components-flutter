// ignore_for_file: must_be_immutable, constant_identifier_names
import 'package:flutter/material.dart' hide Image;
import 'package:twicpics_components/src/types.dart';
import 'package:twicpics_components/widgets/image.dart';
import 'package:twicpics_components/widgets/video.dart';

class Media extends StatefulWidget {
  /// defines how to align the media (image or video) within its bounds.
  Alignment alignment;

  /// defines how to inscribe the media (image or video) into the space allocated during layout.
  BoxFit fit;

  /// defines the type of media to be displayed (image ot video)
  MediaType mediaType;

  /// notifies when media is ready to be displayed
  final ValueChanged<bool> onLoaded;

  /// defines the URLs for the media and its associated poster (if video)
  Urls urls;

  /// defines media display area dimensions
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
        : Video(
            alignment: widget.alignment,
            fit: widget.fit,
            urls: widget.urls,
            onLoaded: (loaded) {
              widget.onLoaded(loaded);
            },
            viewSize: widget.viewSize);
  }
}
