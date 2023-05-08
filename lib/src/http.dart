import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:twicpics_components/src/install.dart';
import 'package:twicpics_components/src/utils.dart';

class TwicCacheManager extends CacheManager {
    static final TwicCacheManager _instance = TwicCacheManager._();
    factory TwicCacheManager() {
        return _instance;
    }
    TwicCacheManager._() : super(
        Config( 
            'twicpics_components', 
            stalePeriod: const Duration( days: 7), 
            maxNrOfCacheObjects: 200
        ) 
    ) {
        CacheManager.logLevel = config.debug ? CacheManagerLogLevel.verbose : CacheManagerLogLevel.none;
    }
}

Future< File? > get( String url ) async {
    try {
        return await TwicCacheManager().getSingleFile( url );
    }
    on HttpExceptionWithStatus catch ( e ) {
        debugPrint( buildErrorMessage( '$e') );
        return null;
    }   
    catch ( error ) {
        rethrow;
    }
}

Future< Uint8List? > getAsBytes( String url ) async {
    File? file = await get ( url );
    return file != null ? await( file ).readAsBytes() : null;
}

Future< String? > getAsString( String url ) async {
    File? file = await get ( url );
    return file != null ? await( file ).readAsString() : null;
}
