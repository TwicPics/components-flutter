// ignore_for_file: must_be_immutable, constant_identifier_names
import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:twicpics_components/src/http.dart';
import 'package:twicpics_components/src/types.dart' as twic_types;
import 'package:twicpics_components/src/utils.dart';

final RegExp rBYTES = RegExp(r'data:image\/png;base64,([^"]*)');

Future<twic_types.PlaceholderData?> getPlaceholderData(
    {
        required String url, 
        required twic_types.Size viewSize,
    }
) async {
    final response = await getAsString( "$url/inspect" );
    Map? decoded = response != null ? jsonDecode( response ) as Map : null;
    if ( decoded == null ||
        decoded['output']['intrinsicWidth'] == 0 ||
        decoded['output']['height'] == 0 ||
        decoded['output']['width'] == 0
    ) {
        return null;
    }

    final color = decoded['output']['color'] != null
        ? int.tryParse('0xFF${decoded['output']['color'].toString().replaceAll("#", "")}')
        : null;

    final intrinsicWidth = decoded['output']['intrinsicWidth'];
    final height = decoded['output']['height'];
    final width = decoded['output']['width'];

    final deviation = intrinsicWidth != null ?
        width / intrinsicWidth :
        0.0;
    final intrinsicRatio = width / height;
    final viewRatio = viewSize.width / viewSize.height!;
    final actualWidth = max(
        1,
        intrinsicRatio > viewRatio ?
            viewSize.width :
            viewSize.height! * intrinsicRatio
        ).roundToDouble();
    final actualHeight = ( actualWidth / intrinsicRatio ).roundToDouble();

    final parsedBytes = decoded[ 'output' ][ 'image' ] != null ?
        rBYTES.firstMatch( decoded[ 'output' ][ 'image' ] ) :
        null;
    return twic_types.PlaceholderData(
        bytes: parsedBytes != null ? base64Decode( parsedBytes[ 1 ]! ) : null,
        color: color,
        deviation: deviation,
        height: actualHeight,
        width: actualWidth,
    );
}

class CustomPlaceholder extends StatefulWidget {
    Alignment alignment;
    BoxFit fit;
    String? url;
    twic_types.Size viewSize;
    CustomPlaceholder( { 
        super.key, 
        required this.alignment, 
        required this.fit, 
        this.url, 
        required this.viewSize
    } );
    @override
    State<CustomPlaceholder> createState() => _CustomPlaceholderState();
}

class _CustomPlaceholderState extends State<CustomPlaceholder> {
    twic_types.PlaceholderData? placeholderData;
    Debouncer debouncer = Debouncer( ms: 100 );
    void fetch ()async {
        placeholderData = widget.url == null ?
            null :
            await getPlaceholderData(
                url: widget.url!,
                viewSize: widget.viewSize
            );
        if ( mounted ) {
            setState( () {
                placeholderData = placeholderData;
            } );
        }
    }

    @override
    void didChangeDependencies(){
        fetch();
        super.didChangeDependencies();
    }

    @override
    void didUpdateWidget(CustomPlaceholder oldWidget) {
        if ( oldWidget.url != widget.url ) {
            fetch();
        }
        super.didUpdateWidget(oldWidget);
    }

    @override
    Widget build(BuildContext context) {
        if ( placeholderData == null) {
            return Container();
        } else {
            return SizedBox(
                height: widget.viewSize.height!,
                width: widget.viewSize.width,
                child: FittedBox(
                    fit: widget.fit,
                    alignment: widget.alignment,
                    child: ClipRRect(
                        child: Container(
                            width: placeholderData!.width,
                            height: placeholderData!.height,
                            color: placeholderData!.color != null ? Color(placeholderData!.color!) : null,
                            child: placeholderData!.bytes != null ? 
                                ImageFiltered(
                                    imageFilter: ImageFilter.blur(
                                        sigmaX: placeholderData!.deviation!,
                                        sigmaY: placeholderData!.deviation!,
                                    ),
                                    child: Image.memory(
                                        placeholderData!.bytes!,
                                        fit: BoxFit.fill,
                                    ),
                                ) :
                                null,
                        ),
                    ),
                ),
            );
        }
    }
}