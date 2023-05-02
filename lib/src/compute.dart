import 'dart:math';

import 'package:flutter/widgets.dart' hide Placeholder;
import 'package:twicpics_components/src/install.dart';
import 'package:twicpics_components/src/mapping.dart';
import 'package:twicpics_components/src/types.dart';
import 'package:twicpics_components/src/urls.dart';
import 'package:twicpics_components/src/utils.dart';

// ignore: non_constant_identifier_names
double PLACEHOLDER_DIM = 1000;

Size computeActualSize(
    { 
        bool lqip = false,
        required double dpr,
        int? step,
        required Size viewSize
    }
) {
    int actualStep = step ?? config.step;
    double actualDpr = min( max( 1, dpr ), config.maxDpr );
    double ratio = viewSize.height! / viewSize.width;
    double actualWidth = max( actualStep, actualStep * ( viewSize.width / actualStep ).floor() ) * actualDpr;
    double actualHeight = actualWidth * ratio; 

    if ( lqip ) {
        double actualRatio = actualWidth / actualHeight;
        // eslint-disable-next-line no-multi-assign
        actualWidth = actualHeight = PLACEHOLDER_DIM;
        if ( actualRatio > 1 ) {
            actualHeight = ( actualHeight / actualRatio ).floorToDouble();
        } else {
            actualWidth = ( actualHeight * actualRatio ).floorToDouble();
        }
    }

    return Size(
        width: actualWidth.roundToDouble(),
        height: actualHeight.roundToDouble()
    );
}

Alignment computeAlignment ( { Alignment? anchor, Alignment? alignment, BoxFit? fit } ) {
    if ( fit == BoxFit.contain ) {
        return alignment ?? anchor ?? Alignment.center;
    }
    return alignment ?? Alignment.center;
} 

String computePreTransform(
{
    Alignment? anchor,
    String? focus,
    required BoxFit fit,
    String? preTransform
} ) {
    String? actualFocus;
    if ( fit == BoxFit.cover ) {
        actualFocus = focus ?? ( anchor != null ? mappingAlignment[ anchor ] : null) ;
    }
    return '${ preTransform ?? '' }${ actualFocus != null ? 'focus=$actualFocus/' : '' }';
}


String computeUrl( {
    Alignment? anchor,
    String? focus,
    required BoxFit fit,
    double dpr = 1,
    TwicPlaceholder? placeholder,
    String? preTransform,
    required String src,
    int? step,
    required Size viewSize,
    bool lqip = false,
} ) {
    Size size = computeActualSize(
        lqip: lqip,
        dpr: dpr,
        step: step,
        viewSize: viewSize
    );
    return createUrl(
        domain: config.domain,
        src: src,
        transform: '${
            computePreTransform(
                fit: fit, 
                anchor: anchor, 
                focus: focus, 
                preTransform: preTransform
            )}${ mappingFit[ fit ] }=${
                size.width.round()
            }x${
                size.height!.round()
            }',
        output: ( lqip && placeholder != null ) ? mappingPlaceholder[ placeholder ] : '',
    );
}

Size computeViewSize ( {
    double? height,
    required double ratio,
    required double width,
} )
{
    if ( width == double.infinity || width == 0 ) {
        throw ArgumentError( buildErrorMessage( 'unconstrained width' ) );
    }
    if ( ratio == 0 && ( height == double.infinity || ( height != null && height == 0 ) ) ) {
        throw ArgumentError( buildErrorMessage( 'unconstrained height' ) );
    }
    return Size(
        width: width,
        height: ratio != 0 ? width * ratio : height,
    );
}