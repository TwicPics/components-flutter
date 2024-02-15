// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:twicpics_components/src/http.dart';
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
    Uint8List? mediaBytes;
    String? mediaUrl;
    GlobalKey placeholderKey = GlobalKey();
    bool twicDone = false;
    void _init() {
        final tmp = computeUrl(
            anchor: widget.props.anchor,
            dpr: MediaQuery.of( context ).devicePixelRatio,
            fit: widget.props.fit,
            focus: widget.props.focus,
            intrinsic: widget.props.intrinsic,
            lqip: false,
            preTransform: widget.props.preTransform,
            refit: widget.props.refit,
            src: widget.props.src,
            step: widget.props.step,
            viewSize: widget.viewSize,
            videoOptions: widget.props.videoOptions,
        );
        if ( tmp != mediaUrl ){
            twicDone = false;
            mediaUrl = tmp;
            if ( widget.props.eager ) {
                fetch();
            }
        }
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

    void fetch() {
        debouncer.debounce(
            ()async {
                mediaBytes = await getAsBytes( mediaUrl! );
                if ( mounted ) {
                    setState( () {
                        twicDone = true;
                    } );
                }
            } 
        );
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
                        fetch();
                    }
                }
            },
            child: AnimatedCrossFade(
                crossFadeState: mediaBytes != null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
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
                    child: mediaBytes != null ?
                        Image.memory(
                            mediaBytes!,
                            alignment: widget.props.alignment!,
                            fit: widget.props.fit,
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

