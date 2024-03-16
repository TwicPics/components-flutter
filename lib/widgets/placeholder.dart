// ignore_for_file: must_be_immutable, constant_identifier_names
import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:twicpics_components/src/compute.dart';
import 'package:twicpics_components/src/http.dart';
import 'package:twicpics_components/src/parse.dart';
import 'package:twicpics_components/src/types.dart' as twic_types;
import 'package:twicpics_components/src/utils.dart';

Future<twic_types.PlaceholderData?> getPlaceholderData({
  required String url,
  required twic_types.Size viewSize,
}) async {
  final inspectData = parseInspect(await getAsString("$url/inspect"));
  if (inspectData == null) {
    return null;
  }

  final intrinsicRatio = inspectData.width / inspectData.height;
  final viewRatio = viewSize.width / viewSize.height!;

  // determines the appropriate width for displaying the LQIP
  double actualWidth;
  if (intrinsicRatio > viewRatio) {
    // if the intrinsic ratio is greater than the view ratio, use the view's width
    actualWidth = viewSize.width;
  } else {
    // otherwise, calculate the width based on the view's height and intrinsic ratio
    actualWidth = viewSize.height! * intrinsicRatio;
  }

  // ensure the width is at least 1 pixel wide and round it to a double
  actualWidth = max(1, actualWidth).roundToDouble();

  return twic_types.PlaceholderData(
    image: inspectData.image,
    color: inspectData.color,
    deviation: inspectData.width / inspectData.intrinsicWidth,
    height: (actualWidth / intrinsicRatio).roundToDouble(),
    padding: computePadding(inspectData: inspectData, viewSize: viewSize),
    width: actualWidth,
  );
}

class Placeholder extends StatefulWidget {
  Alignment alignment;
  BoxFit fit;
  String? url;
  twic_types.Size viewSize;
  Placeholder(
      {super.key,
      required this.alignment,
      required this.fit,
      this.url,
      required this.viewSize});
  @override
  State<Placeholder> createState() => _PlaceholderState();
}

class _PlaceholderState extends State<Placeholder> {
  twic_types.PlaceholderData? placeholderData;
  Debouncer debouncer = Debouncer(ms: 100);
  void fetch() async {
    placeholderData = widget.url == null
        ? null
        : await getPlaceholderData(url: widget.url!, viewSize: widget.viewSize);
    if (mounted) {
      setState(() {
        placeholderData = placeholderData;
      });
    }
  }

  @override
  void didChangeDependencies() {
    fetch();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(Placeholder oldWidget) {
    if (oldWidget.url != widget.url) {
      fetch();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (placeholderData == null) {
      return Container();
    } else {
      return SizedBox(
        // reserved LQIP emplacement
        height: widget.viewSize.height!,
        width: widget.viewSize.width,
        child: FittedBox(
          // widget responsible for correct positioning of placeholder in its display area
          fit: widget.fit,
          alignment: widget.alignment,
          child: Container(
            // widget responsible for padding and padding color
            // it also determines the size of the actual LQIP
            color: placeholderData!.padding.color,
            width: placeholderData!.width,
            height: placeholderData!.height,
            padding: EdgeInsets.fromLTRB(
                // padding
                placeholderData!.padding.left,
                placeholderData!.padding.top,
                placeholderData!.padding.right,
                placeholderData!.padding.bottom),
            child: Container(
              // widget responsible of displaying blur image or placeholder color
              color: placeholderData!.color ??
                  Colors.black.withOpacity(0), // main or mean color
              child: placeholderData!.image != null
                  ? ClipRect(
                      // this widget prevents blur escaping outside its container
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(
                          sigmaX: placeholderData!.deviation!,
                          sigmaY: placeholderData!.deviation!,
                        ),
                        child: Image.memory(
                          placeholderData!.image!,
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  : Container(),
            ),
          ),
        ),
      );
    }
  }
}
