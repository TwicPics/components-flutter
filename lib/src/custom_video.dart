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
    CustomVideo( {
        super.key, 
        required this.alignment, 
        required this.fit, 
        required this.onLoaded, 
        required this.urls,
        required this.viewSize,
    } );
    @override
    State<CustomVideo> createState() => _CustomVideoState();
}

class _CustomVideoState extends State<CustomVideo> {
    VideoPlayerController? _controller;
    void _initController(String url) {
        _controller = VideoPlayerController.networkUrl(
            Uri.parse( url ), 
            videoPlayerOptions: VideoPlayerOptions( mixWithOthers: true ) 
        )
        ..initialize().then( (_) {
            setState( () {
                widget.onLoaded(true);
                _controller!.setVolume( 0 );
                _controller!.setLooping( true );
                _controller!.play();
            } );
        } );
    }

    Future<void> startVideoPlayer(String link) async {
        if ( _controller == null ) {
            _initController(link);
        } else {
            final oldController = _controller;
            WidgetsBinding.instance.addPostFrameCallback((_) async {
                await oldController!.dispose();
                _initController(link);
            });
            setState(() {
                _controller = null;
            });
        }
    }

    @override
    void didChangeDependencies(){
        if ( widget.urls.media != null ) {
            startVideoPlayer( widget.urls.media! );
        }
        super.didChangeDependencies();
    }

    @override
    void didUpdateWidget(CustomVideo oldWidget) {
        if (
            widget.urls.media != null &&
            ( oldWidget.urls.media != widget.urls.media )
        ) {
            startVideoPlayer( widget.urls.media! );
        }
        super.didUpdateWidget(oldWidget);
    }

    @override
    void dispose() {
        if ( _controller != null ) {
            _controller!.dispose();
        }
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return SizedBox(
            height: widget.viewSize.height!,
            width: widget.viewSize.width,
            child: ( _controller != null && _controller!.value.isInitialized ) ?
                FittedBox(
                    fit: widget.fit,
                    alignment: widget.alignment,
                    child: SizedBox(
                        width: _controller!.value.size.width,
                        height: _controller!.value.size.height,
                        child: VideoPlayer(_controller!)
                    ),
                ): 
                CustomImage(
                    alignment: widget.alignment,
                    fit: widget.fit,
                    url: widget.urls.poster,
                    onLoaded: ( loaded ) => {
                        setState( () {
                            debugPrint('Poster done');
                            widget.onLoaded( true );
                        } )
                    } ,
                )
        ); 
    }
}
