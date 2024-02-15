// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' hide Size;
import 'package:twicpics_components/src/compute.dart';
import 'package:twicpics_components/src/parse.dart';
import 'package:twicpics_components/src/pre_compute.dart';
import 'package:twicpics_components/src/types.dart';
import 'package:twicpics_components/src/twic_media.dart';


class TwicVideo extends StatelessWidget {
    late Attributes props;
    TwicVideo( 
        { 
            super.key,
            TwicPosition? anchor,
            dynamic duration,
            bool? eager,
            String? focus,
            dynamic from,
            String? intrinsic,
            TwicMode? mode,
            TwicPlaceholder? placeholder,
            TwicPosition? position,
            String? preTransform,
            dynamic posterFrom,
            dynamic ratio,
            required String src,
            dynamic to,
            int? step,
            Duration? transitionDuration,
        } 
    ) {

        props= Attributes(
            alignment: parsePosition( position ),
            anchor: parseAnchor( anchor ),
            eager: parseEager( eager ),
            fit: parseMode( mode ),
            mediaType: MediaType.video,
            placeholder: parsePlaceholder( placeholder ),
            preTransform: parsePreTransform( preTransform ),
            src: parseSrc( src ),
            focus: parseFocus( focus ),
            intrinsic: parseIntrinsic( intrinsic ),
            ratio: parseRatio( ratio ),
            step: step,
            transitionDuration: parseTransitionDuration( transitionDuration ),
            videoOptions: preComputeVideoOptions(
                duration: parseDuration( duration ),
                from: parseFrom( from ),
                posterFrom: parsePosterFrom( posterFrom ),
                to: parseTo( to )
            ),
        );
        props.alignment = computeAlignment( anchor: props.anchor, alignment: props.alignment, fit: props.fit );
    }

    @override
    Widget build(BuildContext context) {
        return LayoutBuilder(
            builder: ( BuildContext context, BoxConstraints constraints ) {
                return TwicMedia(
                    viewSize: computeViewSize(
                        width: constraints.maxWidth,
                        ratio: props.ratio,
                        height: constraints.maxHeight,
                    ), 
                    props: props,
                    key: key,
                );
            }
        );
    }
}
