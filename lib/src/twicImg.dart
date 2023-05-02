// ignore_for_file: must_be_immutable
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
    late bool twicLoading;

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
        getLqipData();
    }

    Widget placeholder() => _Placeholder( placeholderData: placeholderData, props: widget.props );

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
        return SizedBox(
            height: widget.viewSize.height!,
            width: widget.viewSize.width!,
            child: ClipRRect(
                child: VisibilityDetector(
                    key: Key( mediaUrl ),
                    onVisibilityChanged: ( visibilityInfo ) {
                        if ( !twicLoading && mounted ) {
                            setState( () { twicLoading = visibilityInfo.visibleFraction > 0; } );
                        }
                    } ,
                    child: twicLoading ? 
                        CachedNetworkImage(
                            alignment: widget.props.alignment!,
                            fit: widget.props.fit,
                            fadeInDuration: widget.props.transitionDuration,
                            fadeInCurve: Curves.ease,
                            height: widget.viewSize.height!,
                            imageUrl: mediaUrl,
                            placeholderFadeInDuration: Duration.zero,
                            placeholder: (context, url) => placeholder(),
                            width: widget.viewSize.width,
                        ): 
                        placeholder(),
                ),
            ),
        );
    }
}

class _Placeholder extends StatelessWidget {
    
    PlaceholderData? placeholderData;
    Attributes props;
    _Placeholder({required this.placeholderData, required this.props});

    @override
    Widget build(BuildContext context) {
        if ( placeholderData == null) {
            return Container();
        } else {
            return FittedBox(
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
                                    tileMode: TileMode.decal,
                                    sigmaX: placeholderData!.deviation!,
                                    sigmaY: placeholderData!.deviation!,
                                ),
                                child: Image.memory(
                                    placeholderData!.bytes!,
                                    fit: BoxFit.fill,
                                ),
                            ) :
                            null,
                    ),
                ),
            );
        }
    }
}

