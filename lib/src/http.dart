import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';


Future< File > get( String url ) async {
    return await DefaultCacheManager ().getSingleFile( url );
}

Future< Uint8List > getAsBytes( String url ) async {
    File file = await get ( url );
    return await file.readAsBytes();
}

Future< String > getAsString( String url ) async {
    File file = await get ( url );
    return await file.readAsString();
}

