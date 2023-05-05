// ignore_for_file: must_be_immutable
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twicpics_components/src/http.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter/widgets.dart' hide Size;
import 'package:twicpics_components/src/compute.dart';
import 'package:twicpics_components/src/parse.dart';
import 'package:twicpics_components/src/placeholder.dart';
import 'package:twicpics_components/src/types.dart';


class TwicImg extends StatelessWidget {
    late Attributes props;
    TwicImg( 
        { 
            super.key,
            Alignment? anchor,
            bool? eager,
            String? focus,
            String? intrinsic,
            TwicMode? mode,
            TwicPlaceholder? placeholder,
            Alignment? alignment,
            String? preTransform,
            dynamic ratio,
            required String src,
            int? step,
            Duration? transitionDuration,
        } 
    ) {
        props= Attributes(
            anchor: anchor,
            eager: parseEager( eager ),
            fit: parseMode( mode ),
            placeholder: parsePlaceholder( placeholder ),
            alignment: alignment,
            preTransform: parsePreTransform( preTransform ),
            src: parseSrc( src ),
            focus: parseFocus( focus ),
            intrinsic: parseIntrinsic( intrinsic ),
            ratio: parseRatio( ratio ),
            step: step,
            transitionDuration: parseTransitionDuration( transitionDuration ),
        );
        props.alignment = computeAlignment( anchor: props.anchor, alignment: props.alignment, fit: props.fit );
    }

    @override
    Widget build(BuildContext context) {
        debugPrint('TwicIm src = ${props.src}');
        return LayoutBuilder(
            builder: ( BuildContext context, BoxConstraints constraints ) {
                return TwicMedia(
                    viewSize: computeViewSize(
                        width: constraints.maxWidth,
                        ratio: props.ratio,
                        height: constraints.maxHeight,
                    ), 
                    props: props,
                    key: UniqueKey(),
                );
            }
        );
    }
}

class TwicMedia extends StatefulWidget {
    final Size viewSize;
    final Attributes props;
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
        debugPrint( 'TwicMedia _init  $mediaUrl' );
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
        debugPrint( 'fetched $mediaUrl' );
        if ( mounted ) {
            setState( () {
                twicDone = true;
            } );
        }
    }

    @override
    Widget build(BuildContext context) {
        debugPrint( 'twicMedia build $mediaUrl' );
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
                secondChild: _Placeholder(
                    props: widget.props,
                    viewSize: widget.viewSize 
                ),
            ),
        );
    }
}

class _Placeholder extends StatefulWidget {
    Size viewSize;
    Attributes props;
    _Placeholder( { required this.props, required this.viewSize } );
    @override
    State<_Placeholder> createState() => _PlaceholderState();
}

class _PlaceholderState extends State<_Placeholder> {

    String? lqipUrl;
    PlaceholderData? placeholderData;

    Future<void> getPlaceholder() async {
        placeholderData = await getPlaceholderData(
            url: lqipUrl!,
            viewSize: widget.viewSize
        );
        debugPrint( 'placeholder fetched $lqipUrl' );
        if ( mounted ) {
            setState( () {
                placeholderData = placeholderData;
            } );
        }
    }

    void _init() {
        if ( widget.props.placeholder == TwicPlaceholder.none ) {
            return;
        }
        final tmp = computeUrl(
            anchor: widget.props.anchor,
            fit: widget.props.fit,
            src: widget.props.src,
            viewSize: widget.viewSize,
            focus: widget.props.focus,
            lqip: true,
            placeholder: widget.props.placeholder,
            preTransform: widget.props.preTransform, 
        );
        if ( lqipUrl != tmp ) {
            lqipUrl = tmp;
            getPlaceholder();
        }
    }

    @override
    void didChangeDependencies(){
        _init();
        super.didChangeDependencies();
    }

    @override
    void didUpdateWidget(_Placeholder oldWidget) {
        _init();
        super.didUpdateWidget(oldWidget);
    }

    @override
    Widget build(BuildContext context) {
        if ( placeholderData == null) {
            return Container();
        } else {
            return SizedBox(
                height: widget.viewSize.height!,
                width: widget.viewSize.width,
                child: FittedBox(
                    fit: widget.props.fit,
                    alignment: widget.props.alignment!,
                    child: ClipRRect(
                        child: Container(
                            width: placeholderData!.width,
                            height: placeholderData!.height,
                            color: placeholderData!.color != null ? Color(placeholderData!.color!) : null,
                            child: placeholderData!.bytes != null ? 
                                ImageFiltered(
                                    imageFilter: ImageFilter.blur(
                                        sigmaX: placeholderData!.deviation!,
                                        sigmaY: placeholderData!.deviation!,
                                    ),
                                    child: Image.memory(
                                        placeholderData!.bytes!,
                                        fit: widget.props.fit,
                                    ),
                                ) :
                                null,
                        ),
                    ),
                ),
            );
        }
    }
}