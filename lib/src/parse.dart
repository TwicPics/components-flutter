import 'package:flutter/widgets.dart' hide Placeholder;
import 'package:twicpics_components/src/install.dart';
import 'package:twicpics_components/src/types.dart';
import 'package:twicpics_components/src/urls.dart';
import 'package:twicpics_components/src/utils.dart';
import 'package:twicpics_components/src/validate.dart';

final RegExp rMedia = RegExp( r'^((?:image|video|media):)?\/*' );
final trimOrUndefined = regExpFinderFactory( trimRegExpFactory( '.+?' ) );
final trimTransformOrUndefined = trimRegExpFactory('.+?', border: '[\\s\\/]');

bool parseEager( bool? eager ) => eager ?? false;

final Map<TwicFit, BoxFit> mappingFit = {
    TwicFit.contain: BoxFit.contain,
    TwicFit.cover: BoxFit.cover,
};
BoxFit parseFit ( TwicFit? fit ) => fit!= null ? mappingFit[ fit ]! : BoxFit.cover;

final parseFocus = trimOrUndefined;

Size? parseIntrinsic( String? value ) {
    if ( value == null || value.isEmpty ) {
        return null;
    }
    final parsed = rValidIntrinsic.firstMatch( value );
    if ( parsed == null ) {
        return null;
    }
    return Size(
        width: getNumber( parsed.group( 2 )! )!,
        height: getNumber( parsed.group( 3 )! )!,
    );
}

TwicPlaceholder parsePlaceholder ( TwicPlaceholder? placeholder ) => placeholder ?? TwicPlaceholder.preview;

final parsePreTransform = regExpFinderFactory( trimTransformOrUndefined, ( p ) => p != null ? '$p/' : null );


String computeSrc(String src) {
    if ( isAbsolute( src:src, domain: config.domain )) {
        return 'media:${src.substring('${config.domain}/'.length)}';
    } else {
        return src.replaceAll(rMedia, 'media:${config.path}');
    }
}

String parseSrc( String src ) {
    String value = trimOrUndefined( src ) ?? '';
    return isAbsolute( src:value, domain: config.domain ) ?
        'media:${ value.substring( '${ config.domain }/'.length ) }' :
        value.replaceAll( rMedia, 'media:${ config.path }' );
}

double parseRatio( dynamic ratio ) {
    if ( ratio == null ) {
        return 1;
    }
    if ( ratio == 'none' ) {
        return 0;
    }
    late double number;
    if ( ratio is num ) {
        number = 1 / ratio;
    } else {
        final parsed = rValidRatio.firstMatch( ratio );
        if (parsed != null) {
            number = ( getNumber( parsed.group(3) ) ?? 1 ) / ( getNumber( parsed.group(2) ) ?? 1 );
        } else {
            number = 1;
        }
    }
    return isPositiveNumber( number ) ? number : 1;
}

Duration parseTransitionDuration ( Duration? transitionDuration) => transitionDuration ?? const Duration( milliseconds: 400 );
