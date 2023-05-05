// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twicpics_components/src/http.dart';
import 'package:twicpics_components/src/twicPlaceholder.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter/widgets.dart' hide Size;
import 'package:twicpics_components/src/compute.dart';
import 'package:twicpics_components/src/types.dart' as twic_types;



class TwicMedia extends StatefulWidget {
    final twic_types.Size viewSize;
    final twic_types.Attributes props;
    const TwicMedia( {
        Key? key,
        required this.viewSize,
        required this.props,
    } ) : super(key: key);
    @override
    State<TwicMedia> createState() => _TwicMediaState();
}

class _TwicMediaState extends State<TwicMedia> {
    Uint8List? mediaBytes;
    String? mediaUrl;
    bool twicDone = false;

    void _init() {
        final tmp = computeUrl(
            anchor: widget.props.anchor,
            dpr: MediaQuery.of( context ).devicePixelRatio,
            fit: widget.props.fit,
            src: widget.props.src,
            viewSize: widget.viewSize,
            focus: widget.props.focus,
            lqip: false,
            preTransform: widget.props.preTransform,
            step: widget.props.step
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

    Future<void> fetch( ) async {
        final response = await get( mediaUrl! );
        mediaBytes = response.bodyBytes;
        if ( mounted ) {
            setState( () {
                twicDone = true;
            } );
        }
    }

    @override
    Widget build(BuildContext context) {
        return VisibilityDetector(
            key: widget.key!,
            onVisibilityChanged: ( visibilityInfo ) {
                if ( mounted ) {
                    if ( !twicDone && visibilityInfo.visibleFraction> 0 ) {
                        fetch();
                    }
                }
            } ,
            child: AnimatedCrossFade(
                crossFadeState: twicDone ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                duration: widget.props.transitionDuration,
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
                    key: widget.key,
                    props: widget.props,
                    viewSize: widget.viewSize 
                ),
            ),
        );
    }
}

