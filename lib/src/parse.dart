import 'dart:convert';

import 'package:flutter/widgets.dart' hide Placeholder;
import 'package:twicpics_components/src/install.dart';
import 'package:twicpics_components/src/types.dart';
import 'package:twicpics_components/src/urls.dart';
import 'package:twicpics_components/src/utils.dart';
import 'package:twicpics_components/src/validate.dart';

final RegExp rMedia = RegExp(r'^((?:image|video|media):)?\/*');
final trimOrUndefined = regExpFinderFactory(trimRegExpFactory('.+?'));
final trimTransformOrUndefined = trimRegExpFactory('.+?', border: '[\\s\\/]');

Alignment? parseAnchor(TwicPosition? anchor) => parsePosition(anchor);

Map<String, bool> mappingBoolean = {
  'true': true,
  'false': false,
  '': true,
};

bool? parseBoolean(dynamic value) {
  if (value is bool) {
    return value;
  }
  if (value == null) {
    return false;
  }
  return mappingBoolean[value.toString().trim()];
}

final RegExp rColor = RegExp(
    r'(?:rgba?\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*(?:,\s*([0-9]*\.[0-9]+|[0-9]+)\s*\))?)|(?:(?:#?([a-fA-F\d]{2})([a-fA-F\d]{2})([a-fA-F\d]{2})))');
Color? parseColor(String? value) {
  if (value == null) return null;

  final RegExpMatch? parsed = rColor.firstMatch(value);
  if (parsed == null) return null;

  return Color.fromRGBO(
    parsed.group(1) != null
        ? int.parse(parsed.group(1)!)
        : int.parse(parsed.group(5)!, radix: 16),
    parsed.group(2) != null
        ? int.parse(parsed.group(2)!)
        : int.parse(parsed.group(6)!, radix: 16),
    parsed.group(3) != null
        ? int.parse(parsed.group(3)!)
        : int.parse(parsed.group(7)!, radix: 16),
    parsed.group(4) != null ? double.parse(parsed.group(4)!) : 1.0,
  );
}

const parseDuration = parseNumber;

bool parseEager(bool? eager) => eager ?? false;

final parseFocus = trimOrUndefined;

const parseFrom = parseNumber;

final RegExp rPreviewImage = RegExp(r'data:image\/png;base64,([^"]*)');

InspectData? parseInspect(String? value) {
  Map? map = value != null ? jsonDecode(value) as Map : null;
  if (map == null ||
      map['output'] == null ||
      map['output']['intrinsicWidth'] == 0 ||
      map['output']['height'] == 0 ||
      map['output']['width'] == 0) {
    return null;
  }
  final previewImage = map['output']['image'] != null
      ? rPreviewImage.firstMatch(map['output']['image'])
      : null;

  return InspectData(
      color: parseColor(map['output']['color']),
      height: parseDouble(map['output']['height']),
      image: previewImage != null ? base64Decode(previewImage[1]!) : null,
      intrinsicWidth: parseDouble(map['output']['intrinsicWidth']),
      width: parseDouble(map['output']['width']),
      padding: parsePadding(map['output']['padding']));
}

Size? parseIntrinsic(String? value) {
  if (value == null || value.isEmpty) {
    return null;
  }
  final parsed = rValidIntrinsic.firstMatch(value);
  if (parsed == null) {
    return null;
  }
  return Size(
    width: getNumber(parsed.group(2)!)!,
    height: getNumber(parsed.group(3)!)!,
  );
}

final Map<TwicMode, BoxFit> modeToFit = {
  TwicMode.contain: BoxFit.contain,
  TwicMode.cover: BoxFit.cover,
};
BoxFit parseMode(TwicMode? mode) =>
    mode != null ? modeToFit[mode]! : BoxFit.cover;

final Map<TwicPosition, Alignment> positionToAlignment = {
  TwicPosition.bottom: Alignment.bottomCenter,
  TwicPosition.bottomLeft: Alignment.bottomLeft,
  TwicPosition.bottomRight: Alignment.bottomRight,
  TwicPosition.center: Alignment.center,
  TwicPosition.left: Alignment.centerLeft,
  TwicPosition.right: Alignment.centerRight,
  TwicPosition.top: Alignment.topCenter,
  TwicPosition.topLeft: Alignment.topLeft,
  TwicPosition.topRight: Alignment.topRight,
};

num? parseNumber(dynamic value) {
  if (value is! num) {
    String? trimmed = trimOrUndefined(value);
    value = trimmed != null ? num.tryParse(trimmed) : null;
  }
  return isPositiveNumber(value) ? value : null;
}

double parseDouble(dynamic value) {
  return parseNumber(value)?.toDouble() ?? 0;
}

PaddingData parsePadding(Map<String, dynamic>? value) {
  if (value == null) {
    return PaddingData();
  }

  return PaddingData(
    bottom: parseDouble(value['bottom']),
    left: parseDouble(value['left']),
    right: parseDouble(value['right']),
    top: parseDouble(value['top']),
    color: parseColor(value['color']),
  );
}

Alignment? parsePosition(TwicPosition? position) =>
    position != null ? positionToAlignment[position] : null;

TwicPlaceholder parsePlaceholder(TwicPlaceholder? placeholder) =>
    placeholder ?? TwicPlaceholder.preview;

const parsePosterFrom = parseNumber;

final parsePreTransform = regExpFinderFactory<String>(
    trimTransformOrUndefined,
    (p) =>
        p != null ? RegExp(r'^/*(.*[^/])/*$').firstMatch(p)?.group(1) : null);

String computeSrc(String src) {
  if (isAbsolute(src: src, domain: config.domain)) {
    return 'media:${src.substring('${config.domain}/'.length)}';
  } else {
    return src.replaceAll(rMedia, 'media:${config.path}');
  }
}

String parseSrc(String src) {
  String value = trimOrUndefined(src) ?? '';
  return isAbsolute(src: value, domain: config.domain)
      ? 'media:${value.substring('${config.domain}/'.length)}'
      : value.replaceAll(rMedia, 'media:${config.path}');
}

double parseRatio(dynamic ratio) {
  if (ratio == null) {
    return 1;
  }
  if (ratio == 'none') {
    return 0;
  }
  late double number;
  if (ratio is num) {
    number = 1 / ratio;
  } else {
    final parsed = rValidRatio.firstMatch(ratio);
    if (parsed != null) {
      number =
          (getNumber(parsed.group(3)) ?? 1) / (getNumber(parsed.group(2)) ?? 1);
    } else {
      number = 1;
    }
  }
  return isPositiveNumber(number) ? number : 1;
}

String? parseRefit(dynamic value) {
  bool? parsedBoolean = parseBoolean(value);
  if (parsedBoolean == null) {
    String? trimmed = trimOrUndefined((value ?? '').toString());
    return trimmed?.replaceAll(RegExp(r'\s'), '');
  }
  return parsedBoolean ? '' : null;
}

const parseTo = parseNumber;

Duration parseTransitionDuration(Duration? transitionDuration) =>
    transitionDuration ?? const Duration(milliseconds: 400);
