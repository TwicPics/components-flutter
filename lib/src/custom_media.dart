// ignore_for_file: must_be_immutable, constant_identifier_names
import 'package:flutter/material.dart';
import 'package:twicpics_components/src/custom_image.dart';
import 'package:twicpics_components/src/custom_video.dart';
import 'package:twicpics_components/src/types.dart';

class CustomMedia extends StatefulWidget {
    Alignment alignment;
    BoxFit fit;
    MediaType mediaType;
    final ValueChanged<bool> onLoaded;
    Urls urls;
    Size viewSize;
    CustomMedia( {
        super.key,
        required this.alignment,
        required this.fit,
        required this.mediaType,
        required this.onLoaded,
        required this.urls,
        required this.viewSize
    } );

    @override
    State<CustomMedia> createState() => _CustomMediaState();
}

class _CustomMediaState extends State<CustomMedia> {
    @override
    Widget build(BuildContext context) {
        return  widget.mediaType == MediaType.image ?
            CustomImage(
                alignment: widget.alignment,
                fit: widget.fit,
                url: widget.urls.media,
                onLoaded: ( loaded ) {
                    widget.onLoaded( loaded );
                },
            ):
            CustomVideo(
                alignment: widget.alignment,
                fit: widget.fit,
                urls: widget.urls,
                onLoaded: ( loaded ) {
                    widget.onLoaded( loaded );
                },
                viewSize: widget.viewSize 
            );
    }
}
