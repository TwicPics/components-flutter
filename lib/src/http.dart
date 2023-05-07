import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:twicpics_components/src/utils.dart';

Future< File? > get( String url ) async {
    try {
        return await DefaultCacheManager().getSingleFile( url );
    }
    catch ( error ) {
        debugPrint( buildErrorMessage( 'Failed to load $url: $error') );
        return null;
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
