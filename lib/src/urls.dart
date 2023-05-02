// ignore_for_file: unnecessary_brace_in_string_interps, constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'dart:math';

RegExp _rPath = RegExp(
    r'^(?:(auth|placeholder|rel)|(image|media|video)|[^:]*):(\/*)((v[0-9]+(?=[/?]))?[^?]*(\?.*)?)$');
const int FULL_PATH = 4;
const int MEDIA = 2;
const int QUERY = 6;
const int RESERVED = 5;
const int SPECIAL = 1;
const String VERSION = 'v1';

bool isAbsolute( { String src = '', String domain = '' } ) =>
    ( src.substring( 0, min( src.length, domain.length + 1 ) ) == '$domain/' );

String createUrl( {
    required String domain,
    String? output,
    double? quality,
    required String src,
    String transform = ''
} ) {
    bool _isAbsolute = isAbsolute( src: src, domain: domain );
    String path = _isAbsolute ? 'media:${ src.substring( '$domain/'.length ) }' : src;
    RegExpMatch? parsed = _rPath.firstMatch( path );
    if ( parsed == null ) {
        return '';
    }
    bool isMedia = parsed.group( MEDIA ) != null;
    String actualOutput = ( output != null && output.isNotEmpty ) ?
        '/output=$output':
        '';
    String actualPath = isMedia ? parsed.group( FULL_PATH ) ?? '' : path;
    String actualQuality = quality != null ? '/quality=$quality' : '';
    String actualTransform = transform.isNotEmpty ? '/$transform' : '';
    return '${
        domain
    }/${
        ( ( parsed.group( SPECIAL ) != null || parsed.group( RESERVED ) != null ) ) ?
        // old syntax
        '${
            VERSION
        }${
            actualTransform
        }${
            actualOutput
        }/${
            isMedia ? '${parsed[MEDIA]}:${actualPath}' : actualPath
        }${
            actualQuality
        }' :
        // catch-all syntax
        '${
            actualPath
        }${
            parsed.group( QUERY ) != null ? '&' : '?'
        }twic=${
            VERSION
        }${
            actualTransform
        }${
            actualOutput
        }${
            actualQuality
        }'
    }';
}
