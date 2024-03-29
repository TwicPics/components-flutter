// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' hide Size;
import 'package:twicpics_components/src/compute.dart';
import 'package:twicpics_components/src/parse.dart';
import 'package:twicpics_components/src/types.dart';
import 'package:twicpics_components/widgets/wrapper.dart';

/// A widget that displays images using the TwicPics API under the hood, offering pixel-perfect rendering
/// with optimized Cumulative Layout Shift (CLS), Low-Quality Image Placeholder (LQIP), and lazy loading.
///
/// For more information on [TwicImg] widget API, please visit: https://www.twicpics.com/docs/components/flutter#twicimg
class TwicImg extends StatelessWidget {
  late Attributes props;
  TwicImg({
    super.key,
    TwicPosition? anchor,
    bool? eager,
    String? focus,
    String? intrinsic,
    TwicMode? mode,
    TwicPlaceholder? placeholder,
    TwicPosition? position,
    String? preTransform,
    dynamic ratio,
    required String src,
    dynamic refit,
    int? step,
    Duration? transitionDuration,
  }) {
    props = Attributes(
      alignment: parsePosition(position),
      anchor: parseAnchor(anchor),
      eager: parseEager(eager),
      fit: parseMode(mode),
      mediaType: MediaType.image,
      placeholder: parsePlaceholder(placeholder),
      preTransform: parsePreTransform(preTransform),
      refit: parseRefit(refit),
      src: parseSrc(src),
      focus: parseFocus(focus),
      intrinsic: parseIntrinsic(intrinsic),
      ratio: parseRatio(ratio),
      step: step,
      transitionDuration: parseTransitionDuration(transitionDuration),
    );
    props.alignment = computeAlignment(
        anchor: props.anchor, alignment: props.alignment, fit: props.fit);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Wrapper(
        viewSize: computeViewSize(
          width: constraints.maxWidth,
          ratio: props.ratio,
          height: constraints.maxHeight,
        ),
        props: props,
        key: key,
      );
    });
  }
}
