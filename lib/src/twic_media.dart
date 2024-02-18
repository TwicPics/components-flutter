// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:twicpics_components/src/custom_image.dart';
import 'package:twicpics_components/src/custom_video.dart';
import 'package:twicpics_components/src/custom_placeholder.dart';
import 'package:twicpics_components/src/compute.dart';
import 'package:twicpics_components/src/types.dart' as twic_types;
import 'package:twicpics_components/src/utils.dart';
import 'package:visibility_detector/visibility_detector.dart';

class TwicMedia extends StatefulWidget {
    final twic_types.Size viewSize;
    final twic_types.Attributes props;
    final uid = UniqueKey();
    TwicMedia( {
        Key? key,
        required this.viewSize,
        required this.props,
    } ) : super(key: key);
    @override
    State<TwicMedia> createState() => _TwicMediaState();
}

class _TwicMediaState extends State<TwicMedia> {
    Debouncer debouncer = Debouncer( ms: 100 );
    twic_types.Urls ? urls; 
    GlobalKey mediaKey = GlobalKey();
    GlobalKey placeholderKey = GlobalKey();
    bool twicDone = false;
    bool visible = false;
    void _init() {
        debouncer.debounce(
            (){
                final tmpUrls = computeUrls(
                    anchor: widget.props.anchor,
                    dpr: MediaQuery.of( context ).devicePixelRatio,
                    fit: widget.props.fit,
                    focus: widget.props.focus,
                    intrinsic: widget.props.intrinsic,
                    mediaType: widget.props.mediaType,
                    placeholder: widget.props.placeholder,
                    preTransform: widget.props.preTransform,
                    refit: widget.props.refit,
                    src: widget.props.src,
                    step: widget.props.step,
                    videoOptions: widget.props.videoOptions,
                    viewSize: widget.viewSize,
                );
                if ( tmpUrls.media != urls?.media ) {
                    twicDone = false;
                    setState( () {
                        urls = tmpUrls;
                        visible = visible || widget.props.eager;
                    } );
                }
            }
        );
    }

    @override
    void didChangeDependencies(){
        _init();
        super.didChangeDependencies(); 
    }

    @override
    void didUpdateWidget(TwicMedia oldWidget) {
        _init();
        super.didUpdateWidget(oldWidget);
    }

    @override

    void initState() {
        placeholderKey = GlobalKey();
        super.initState();
    }

    @override
    void dispose() {
        debouncer.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return VisibilityDetector(
            key: widget.uid,
            onVisibilityChanged: ( visibilityInfo ) {
                if ( mounted ) {
                    if ( !twicDone && visibilityInfo.visibleFraction> 0 ) {
                        setState( () {
                            visible = true;
                        } );
                    }
                }
            },
            child: AnimatedCrossFade(
                crossFadeState: twicDone ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 1),
                reverseDuration: widget.props.transitionDuration,
                firstCurve: Curves.easeIn,
                secondCurve: Curves.easeOut,
                layoutBuilder: ( topChild, topChildKey, bottomChild, bottomChildKey ) => Stack(
                    children: [
                        Positioned(
                            key:bottomChildKey,
                            child: bottomChild
                        ),
                        Positioned(
                            key:topChildKey,
                            child: topChild
                        )
                    ],    
                ),
                firstChild: SizedBox(
                    height: widget.viewSize.height!,
                    width: widget.viewSize.width,
                    child: ( visible && urls?.media != null ) ?
                        (
                            widget.props.mediaType == twic_types.MediaType.image ?
                                CustomImage(
                                    key: mediaKey,
                                    alignment: widget.props.alignment!,
                                    fit: widget.props.fit,
                                    url: urls!.media,
                                    onLoaded: ( loaded ) => {
                                        setState( () {
                                            twicDone = true;
                                        } )
                                    } ,
                                ):
                                CustomVideo(
                                    key: mediaKey,
                                    alignment: widget.props.alignment!,
                                    fit: widget.props.fit,
                                    urls: urls!,
                                    onLoaded: ( loaded ) => {
                                        setState( () {
                                            twicDone = true;
                                        } )
                                    } ,
                                    viewSize: widget.viewSize 
                                )
                        ) :
                        null
                    ),
                secondChild: CustomPlaceholder(
                    key: placeholderKey,
                    alignment: widget.props.alignment!,
                    fit: widget.props.fit,
                    url: urls!.placeholder,
                    viewSize: widget.viewSize 
                ),
            ),
        );
    }
}

