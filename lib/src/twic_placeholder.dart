// ignore_for_file: must_be_immutable, constant_identifier_names
import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:twicpics_components/src/compute.dart';
import 'package:twicpics_components/src/http.dart';
import 'package:twicpics_components/src/install.dart';
import 'package:twicpics_components/src/types.dart' as twic_types;
import 'package:twicpics_components/src/utils.dart';

const COLOR = 3;
const DEVIATION = 4;
const BYTES = 5;
const HEIGHT = 2;
const WIDTH = 1;

final RegExp _rLqipData = RegExp(
    r'(?:(?:width="([0-9]*)").*(?:height="([0-9]*)")).*(?:(?:background:#([0-9a-fA-F]*)")|(?:stdDeviation="([^"]*)).*(?:href="data:image\/png;base64,([^"]*)))'
);

Future<twic_types.PlaceholderData?> getPlaceholderData(
    {
        required String url, 
        required twic_types.Size viewSize,
    }
) async {
    if ( config.debug ) {
        debugPrint( 'TwicPlaceholder: $url' );
    }
    final response = await getAsString( url );
    if ( response == null ) {
        return null;
    }
    final parsed = _rLqipData.firstMatch( response );
    if ( parsed == null ) {
        return null;
    }
    final intrinsicWidth = parsed[ WIDTH ] != null ?
        ( getNumber( parsed[ WIDTH ] ) ?? 0 ) :
        0;
    final intrinsicHeight = parsed[ HEIGHT ] != null ?
        ( getNumber( parsed[ HEIGHT ] ) ?? 0 ) :
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
    return twic_types.PlaceholderData( 
        bytes: parsed[ BYTES ] != null ? base64Decode(parsed[ BYTES ]!) : null,
        color: parsed[ COLOR ] != null ? int.tryParse('0xFF${ parsed[ COLOR ] }') : null,
        deviation: parsed[ DEVIATION ] != null ? getNumber( parsed[ DEVIATION] ): null,
        height: actualHeight,
        width: actualWidth,
    );
}

class TwicPlaceholder extends StatefulWidget {
    twic_types.Size viewSize;
    twic_types.Attributes props;
    TwicPlaceholder( { super.key, required this.props, required this.viewSize } );
    @override
    State<TwicPlaceholder> createState() => _TwicPlaceholderState();
}

class _TwicPlaceholderState extends State<TwicPlaceholder> {
    String? lqipUrl;
    twic_types.PlaceholderData? placeholderData;
    void fetch() {
        debounce(
            ()async {
                if ( config.debug ) {
                    debugPrint( 'TwicPlaceholder: $lqipUrl' );
                }
                placeholderData = await getPlaceholderData(
                    url: lqipUrl!,
                    viewSize: widget.viewSize
                );
                if ( mounted ) {
                    setState( () {
                        placeholderData = placeholderData;
                    } );
                }
            },
            DebounceOptions(
                leading: false,
                ms: 100,
            ) 
        )();
    }

    void _init() {
        if ( widget.props.placeholder == twic_types.TwicPlaceholder.none ) {
            return;
        }
        final tmp = computeUrl(
            anchor: widget.props.anchor,
            fit: widget.props.fit,
            src: widget.props.src,
            viewSize: widget.viewSize,
            focus: widget.props.focus,
            lqip: true,
            placeholder: widget.props.placeholder,
            preTransform: widget.props.preTransform, 
        );
        if ( lqipUrl != tmp ) {
            lqipUrl = tmp;
            fetch();
        }
    }

    @override
    void didChangeDependencies(){
        _init();
        super.didChangeDependencies();
    }

    @override
    void didUpdateWidget(TwicPlaceholder oldWidget) {
        _init();
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
                    fit: widget.props.fit,
                    alignment: widget.props.alignment!,
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
                                        fit: widget.props.fit,
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
