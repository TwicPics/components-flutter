// ignore_for_file: must_be_immutable
import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            TwicFit? fit,
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
            fit: parseFit( fit ),
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
                        height: constraints.maxHeight
                    ), 
                    props: props
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
    late String mediaUrl;
    PlaceholderData? placeholderData;
    bool twicLoading = false;
    bool twicDone = false;

    Uint8List? mediaBytes;

    void getLqipData() {
        if ( widget.props.placeholder != TwicPlaceholder.none  ) {
            placeholderData = null;
            getPlaceholderData(
                url: computeUrl(
                    anchor: widget.props.anchor,
                    fit: widget.props.fit,
                    src: widget.props.src,
                    viewSize: widget.viewSize,
                    focus: widget.props.focus,
                    lqip: true,
                    placeholder: widget.props.placeholder,
                    preTransform: widget.props.preTransform, 
                ),
                viewSize: widget.viewSize,
            ).then( ( value ) => {
                if ( mounted ) {
                    setState( () {
                        placeholderData = value;
                    } )
                }
            } );
        } else {
            if ( mounted ) {
                setState( () {
                    placeholderData = null;
                } );
            }
        }
    }

    @override
    void initState() {
        super.initState();
        twicLoading = widget.props.eager;
        getLqipData();
    }

    @override
    void didUpdateWidget(TwicMedia oldWidget) {
        super.didUpdateWidget(oldWidget);
        twicLoading = widget.props.eager;
        twicDone = false;
        getLqipData();
    }

    Widget placeholder() => _Placeholder( placeholderData: placeholderData, props: widget.props, viewSize: widget.viewSize );

    Future<void> readNetworkImage( String imageUrl ) async {
        final ByteData data = await NetworkAssetBundle( Uri.parse(imageUrl) ).load(imageUrl);
        mediaBytes = data.buffer.asUint8List();
        if ( mounted ) {
            setState( () {
                twicDone = true;
            } );
        }
    }

    @override
    Widget build(BuildContext context) {
        mediaUrl = computeUrl(
            anchor: widget.props.anchor,
            dpr: MediaQuery.of(context).devicePixelRatio,
            fit: widget.props.fit,
            src: widget.props.src,
            viewSize: widget.viewSize,
            focus: widget.props.focus,
            lqip: false,
            preTransform: widget.props.preTransform,
            step: widget.props.step
        );
        if ( !twicDone && widget.props.eager) {
            readNetworkImage( mediaUrl );
        }
        return VisibilityDetector(
            key: Key( mediaUrl ),
            onVisibilityChanged: ( visibilityInfo ) {
                if ( !twicLoading && mounted ) {
                    twicLoading = visibilityInfo.visibleFraction > 0;
                    if ( twicLoading ) {
                        readNetworkImage(mediaUrl);
                    }
                }
            } ,
            child: AnimatedCrossFade(
                crossFadeState: twicDone ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                duration: widget.props.transitionDuration,
                firstCurve: Curves.easeIn,
                secondCurve: Curves.easeOut,
                layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) => Stack(
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
                            height: widget.viewSize.height!,
                            width: widget.viewSize.width,
                        ):
                        null
                    ),
                secondChild: placeholder(),
            ),
        );
    }
}

class _Placeholder extends StatelessWidget {
    Size viewSize;
    PlaceholderData? placeholderData;
    Attributes props;
    _Placeholder({required this.placeholderData, required this.props, required this.viewSize});

    @override
    Widget build(BuildContext context) {
        if ( placeholderData == null) {
            return Container();
        } else {
            return SizedBox(
                height: viewSize.height!,
                width: viewSize.width,
                child: FittedBox(
                    fit: props.fit,
                    alignment: props.alignment!,
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
                                        height: placeholderData!.width,
                                        width: placeholderData!.height,
                                        fit: props.fit,
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

