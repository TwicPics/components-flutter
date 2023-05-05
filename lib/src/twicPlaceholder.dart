// ignore_for_file: must_be_immutable
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' hide Size;
import 'package:twicpics_components/src/compute.dart';
import 'package:twicpics_components/src/placeholder.dart';
import 'package:twicpics_components/src/types.dart' as twic_types;


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

    Future<void> fetch() async {
        placeholderData = await getPlaceholderData(
            url: lqipUrl!,
            viewSize: widget.viewSize
        );
        if ( mounted ) {
            setState( () {
                placeholderData = placeholderData;
            } );
        }
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