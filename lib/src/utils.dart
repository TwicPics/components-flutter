String buildErrorMessage ( String message ) => 'twicpics-components $message';

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
