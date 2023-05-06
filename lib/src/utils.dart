import 'dart:async';

String buildErrorMessage ( String message ) => 'twicpics-components $message';

typedef DebounceFunction = void Function();

class DebounceOptions {
    bool? leading;
    int? ms;
    bool? trailing;
    DebounceOptions( { this.leading, this.ms, this.trailing } );
}

DebounceFunction debounce( DebounceFunction fn, DebounceOptions? options ) {
    Timer? timer;
    // ignore: no_leading_underscores_for_local_identifiers
    DebounceOptions _options = DebounceOptions(
        leading: true,
        ms: 0,
        trailing: true,
    );
    if ( options != null ) {
        _options.leading = options.leading ?? true;
        _options.ms = options.ms ?? 0;
        _options.trailing = options.trailing ?? true;
    }
    return () {
        if ( timer == null && _options.leading! ) {
            fn();
        }
        timer?.cancel();
        timer = Timer(
            Duration( milliseconds: _options.ms! ),
            () {
                timer = null;
                if ( _options.trailing! ) {
                    fn();
                }
            },
        );
    };
}

bool isPositiveNumber( dynamic value ) => value is num && value > 0;
double? getNumber( dynamic value ) => value != null ? double.tryParse( value.toString() ) : null;

typedef Filter< T > = T? Function( T? value);
T? Function( T? value) regExpFinderFactory< T extends String?>( RegExp regExp, [ Filter< T >? filter ] ) {
    return ( T? value ) {
        dynamic found;
        if ( value != null ) {
            regExp.allMatches( value ).forEach( ( match ) {
                found = match.group(1);
            } );
        }
        return filter != null ? filter(found) : found;
    };
}

RegExp trimRegExpFactory( 
    dynamic items,
    {
        String border = '\\s', 
        bool caseSensitive = true,
        bool dotAll = false,
        bool multiLine = false,
        bool unicode = false,
        
    }
) {
    final regexItems = items is List< String > ? items.join( '|' ) : items;
    return RegExp(
        '^(?:$border)*($regexItems)(?:$border)*\$',
        multiLine: multiLine,
        caseSensitive: caseSensitive,
        unicode: unicode,
        dotAll: dotAll,
    );
}
