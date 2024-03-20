// ignore_for_file: must_be_immutable, constant_identifier_names
import 'dart:typed_data';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/material.dart' as legacy show Image;
import 'package:twicpics_components/src/http.dart';

class Image extends StatefulWidget {
  /// defines how to align the image within its bounds.
  Alignment alignment;

  /// defines how to inscribe the image into the space allocated during layout.
  BoxFit fit;

  /// notifies when image is ready to be displayed
  final ValueChanged<bool> onLoaded;

  /// specifies the image URL to be fetched
  String? url;
  Image(
      {super.key,
      required this.alignment,
      required this.fit,
      required this.onLoaded,
      this.url});
  @override
  State<Image> createState() => _ImageState();
}

class _ImageState extends State<Image> {
  Uint8List? bytes;
  void fetch() async {
    bytes = widget.url == null ? null : await getAsBytes(widget.url!);
    if (mounted) {
      widget.onLoaded(true);
    }
  }

  @override
  void didChangeDependencies() {
    fetch();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(Image oldWidget) {
    if (oldWidget.url != widget.url) {
      fetch();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return bytes != null
        ? legacy.Image.memory(
            bytes!,
            alignment: widget.alignment,
            fit: widget.fit,
          )
        : Container();
  }
}
