// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:twicpics_components/src/types.dart';
import 'package:twicpics_components/src/utils.dart';

const COLOR = 3;
const DEVIATION = 4;
const BYTES = 5;
const HEIGHT = 2;
const WIDTH = 1;

RegExp _rLqipData = RegExp(
    r'(?:(?:width="([0-9]*)").*(?:height="([0-9]*)")).*(?:(?:background:#([0-9a-fA-F]*)")|(?:stdDeviation="([^"]*)).*(?:href="data:image\/png;base64,([^"]*)))');

Future<PlaceholderData?> getPlaceholderData(
    {
        required String url, 
        required Size viewSize
    }
) async {
    final response = await http.get( Uri.parse( url ) );
    if ( response.statusCode != 200 ) {
        return null;
    }

    final parsed = _rLqipData.firstMatch( response.body );
    if ( parsed == null ) {
        return null;
    }

    final intrinsicWidth = parsed[ WIDTH ] != null ?
        ( getNumber( parsed[ WIDTH ]! ) ?? 0 ) :
        0;
    
    final intrinsicHeight = parsed[ HEIGHT ] != null ?
        ( getNumber( parsed[ HEIGHT ]! ) ?? 0 ) :
        0;

    if ( intrinsicHeight == 0  || intrinsicWidth == 0) {
        return null;
    }

    final intrinsicRatio = intrinsicWidth / intrinsicHeight;
    final viewRatio = viewSize.width / viewSize.height!;
    final actualWidth = max(
            1,
            intrinsicRatio > viewRatio ?
                viewSize.width :
                viewSize.height! * intrinsicRatio
    ).roundToDouble();
    final actualHeight = ( actualWidth / intrinsicRatio ).roundToDouble();
    return PlaceholderData( 
        bytes: parsed[ BYTES ] != null ? base64Decode(parsed[ BYTES ]!) : null,
        color: parsed[ COLOR ] != null ? int.tryParse('0xFF${ parsed[ COLOR ] }') : null,
        deviation: parsed[ DEVIATION ] != null ? getNumber( parsed[ DEVIATION] ): null,
        height: actualHeight,
        width: actualWidth,
    );
}
