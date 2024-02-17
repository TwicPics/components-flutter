// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:twicpics_components/src/custom_image.dart';
import 'package:twicpics_components/src/twic_placeholder.dart';
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
    Debouncer debouncer = Debouncer( ms: 500 );
    String? mediaUrl;
    GlobalKey mediaKey = GlobalKey();
    GlobalKey placeholderKey = GlobalKey();
    bool twicDone = false;
    bool visible = false;
    void _init() {
        debouncer.debounce(
            (){
                final tmp = computeUrl(
                    anchor: widget.props.anchor,
                    dpr: MediaQuery.of( context ).devicePixelRatio,
                    fit: widget.props.fit,
                    focus: widget.props.focus,
                    intrinsic: widget.props.intrinsic,
                    lqip: false,
                    poster: widget.props.mediaType == twic_types.MediaType.video,
                    preTransform: widget.props.preTransform,
                    refit: widget.props.refit,
                    src: widget.props.src,
                    step: widget.props.step,
                    viewSize: widget.viewSize,
                    videoOptions: widget.props.videoOptions,
                );

                if ( tmp != mediaUrl ){
                    debugPrint('url changed $tmp');
                    twicDone = false;
                    mediaUrl = tmp;
                    if ( widget.props.eager ) {
                        setState( () {
                            visible = true;
                        } );
                    }
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
                    child: ( visible && mediaUrl != null ) ?
                        CustomImage(
                            key: mediaKey,
                            alignment: widget.props.alignment!,
                            fit: widget.props.fit,
                            url: mediaUrl!,
                            onLoaded: ( loaded ) => {
                                setState( () {
                                    twicDone = true;
                                } )
                            } ,
                        ):
                        null
                    ),
                secondChild: TwicPlaceholder(
                    key: placeholderKey,
                    props: widget.props,
                    viewSize: widget.viewSize 
                ),
            ),
        );
    }
}

