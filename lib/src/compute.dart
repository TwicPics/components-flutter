import 'dart:math';
import 'package:flutter/widgets.dart' hide Placeholder;
import 'package:twicpics_components/src/install.dart';
import 'package:twicpics_components/src/types.dart';
import 'package:twicpics_components/src/urls.dart';
import 'package:twicpics_components/src/utils.dart';

// ignore: non_constant_identifier_names
double PLACEHOLDER_DIM = 1000;

Size computeActualSize(
    { 
        required double dpr,
        Size? intrinsic,
        bool lqip = false,
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
            actualHeight = ( actualWidth / actualRatio ).floorToDouble();
        } else {
            actualWidth = ( actualHeight * actualRatio ).floorToDouble();
        }
    }

    if ( intrinsic != null && ( actualHeight > intrinsic.height! || actualWidth > intrinsic.width ) ) {
        double actualRatio = actualWidth / actualHeight;
        if ( actualHeight > intrinsic.height! ) {
            actualHeight = intrinsic.height!;
            actualWidth = ( actualHeight * actualRatio ).floorToDouble();
        } else {
            actualWidth = intrinsic.width;
            actualHeight = ( actualWidth / actualRatio ).floorToDouble();
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

final Map<Alignment, String> mappingAlignment = {
    Alignment.bottomCenter: 'bottom',
    Alignment.bottomLeft: 'bottom-left',
    Alignment.bottomRight: 'bottom-right',
    Alignment.center: 'center',
    Alignment.centerLeft: 'left',
    Alignment.centerRight: 'right',
    Alignment.topCenter: 'top',
    Alignment.topLeft: 'top-left',
    Alignment.topRight: 'top-right',
};

String computePreTransform(
{
    Alignment? anchor,
    String? focus,
    required BoxFit fit,
    String? preTransform,
    String? refit,
} ) {
    String? actualFocus;
    final actualRefit = computeRefit( anchor: anchor, fit: fit, refit: refit );
    if ( fit == BoxFit.cover && refit == null ) {
        actualFocus = focus ?? ( anchor != null ? mappingAlignment[ anchor ] : null) ;
    }
    final finalTransform = ( ( fit == BoxFit.cover ) && ( refit != null ) ) ? null : '/*';
    return '${
        preTransform != null ? '/$preTransform' : ''
    }${
        actualFocus != null ? '/focus=$actualFocus' : ''
    }${
        actualRefit != null ? '/refit=$actualRefit' : ''
    }${
        finalTransform ?? ''
    }';
}

String? computeRefit(
{
    Alignment? anchor,
    required BoxFit fit,
    String? refit
} ) {
    if (refit == null ) {
        return null;
    }
    return '${
        ( fit == BoxFit.contain ) ?
        'auto' :
        'WxH'
    }${
        refit.isEmpty ?
        '':
        '($refit)'
    }${
        ( anchor == null || fit == BoxFit.contain ) ?
        '':
        '@${ mappingAlignment[ anchor ] }'
    }';
}


final Map<BoxFit, String> mappingFit = {
    BoxFit.contain: 'contain',
    BoxFit.cover: 'cover',
};

final Map<TwicPlaceholder, String> mappingPlaceholder = {
    TwicPlaceholder.maincolor: 'maincolor',
    TwicPlaceholder.meancolor: 'meancolor',
    TwicPlaceholder.none: '',
    TwicPlaceholder.preview: 'preview',
};

String computeUrl( UrlData urlData ) {
    final anchor = urlData.anchor;
    final dpr = urlData.dpr;
    final fit = urlData.fit;
    final focus = urlData.focus;
    final intrinsic = urlData.intrinsic;
    final lqip = urlData.lqip;
    final placeholder = urlData.placeholder;
    final poster= urlData.poster;
    final preTransform = urlData.preTransform;
    final refit = urlData.refit;
    final step = urlData.step;
    final src = urlData.src;
    final videoOptions = urlData.videoOptions;
    final Size viewSize = urlData.viewSize;

    Size size = computeActualSize(
        dpr: dpr,
        intrinsic: intrinsic,
        lqip: lqip,
        step: step,
        viewSize: viewSize
    );
    final actualOutput = ( poster ?
        'image' : 
        ( lqip && placeholder != null ) ? mappingPlaceholder[ placeholder ] : ''
    );
    final videoTransform = videoOptions?.videoTransform;
    final posterTransform = videoOptions?.posterTransform;
    final actualVideoTransform = ( ( lqip || poster ) ? posterTransform : videoTransform ) ?? '';
    final actualTransform = '${
        computePreTransform(
            fit: fit, 
            anchor: anchor, 
            focus: focus, 
            preTransform: preTransform,
            refit: refit,
        )
    }$actualVideoTransform';

    return createUrl(
        domain: config.domain,
        context: Context( mode: mappingFit[ fit ] ?? 'cover', size: size ),
        src: src,
        transform: actualTransform,
        output: actualOutput,
    );
}

Urls computeUrls ( { 
    Alignment? anchor,
    double dpr = 1,
    required BoxFit fit,
    String? focus,
    Size? intrinsic,
    bool lqip = false,
    required MediaType mediaType,
    TwicPlaceholder? placeholder,
    String? preTransform,
    String? refit,
    int? step,
    required String src,
    VideoOptions? videoOptions,
    required Size viewSize,
} ) 
{
    final UrlData urlData = UrlData(
        anchor: anchor,
        dpr: dpr,
        fit: fit,
        focus: focus,
        intrinsic: intrinsic,
        placeholder: placeholder,
        preTransform: preTransform,
        refit: refit,
        src: src,
        step: step,
        videoOptions: videoOptions,
        viewSize: viewSize,
    );
    final mediaUrl = computeUrl( urlData );
    String? placeHolderUrl;
    String? posterUrl;

    if ( placeholder != TwicPlaceholder.none ) {
        urlData.lqip = true;
        placeHolderUrl = computeUrl( urlData );
    }
    if ( mediaType == MediaType.video ) {
        urlData.lqip = false;
        urlData.poster = true;
        posterUrl = computeUrl( urlData );
    }
    return Urls(
        media: mediaUrl,
        placeholder: placeHolderUrl,
        poster: posterUrl,
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