import 'dart:typed_data';
import 'package:flutter/widgets.dart';

class Attributes {
  Alignment? alignment;
  Alignment? anchor;
  bool eager;
  String? focus;
  Size? intrinsic;
  BoxFit fit;
  MediaType mediaType;
  TwicPlaceholder placeholder;
  String? preTransform;
  double ratio;
  String? refit;
  String src;
  int? step;
  Duration transitionDuration;
  VideoOptions? videoOptions;
  Attributes({
    required this.alignment,
    this.anchor,
    required this.eager,
    this.focus,
    this.intrinsic,
    required this.fit,
    required this.mediaType,
    required this.placeholder,
    required this.preTransform,
    required this.ratio,
    this.refit,
    required this.src,
    this.step,
    required this.transitionDuration,
    this.videoOptions,
  });
}

class Config {
  bool cacheCleanOnStartUp = false;
  Duration cacheStalePeriod = const Duration(days: 7);
  int cacheMaxNrOfObjects = 200;
  bool debug = false;
  late String domain;
  double maxDpr = 2;
  String? path;
  int step = 50;
}

class Context {
  String mode = 'cover';
  Size size;
  Context({required this.mode, required this.size});
}

enum MediaType {
  image,
  video,
}

class PlaceholderData {
  Uint8List? bytes;
  Color? color;
  double? deviation;
  late double height;
  late double width;
  PlaceholderData(
      {this.bytes,
      this.color,
      this.deviation,
      required this.height,
      required this.width});
}

class Size {
  double? height;
  double width;
  Size({required this.width, this.height});
}

enum TwicMode {
  contain,
  cover,
}

enum TwicPosition {
  bottom,
  bottomLeft,
  bottomRight,
  center,
  left,
  right,
  top,
  topLeft,
  topRight,
}

enum TwicPlaceholder {
  preview,
  maincolor,
  meancolor,
  none,
}

class UrlData {
  Alignment? anchor;
  double dpr;
  BoxFit fit;
  String? focus;
  Size? intrinsic;
  bool lqip;
  MediaType mediaType;
  TwicPlaceholder? placeholder;
  bool poster;
  String? preTransform;
  String? refit;
  int? step;
  String src;
  VideoOptions? videoOptions;
  Size viewSize;
  UrlData(
      {this.anchor,
      this.dpr = 1,
      required this.fit,
      this.focus,
      this.intrinsic,
      this.lqip = false,
      this.mediaType = MediaType.image,
      this.placeholder,
      this.poster = false,
      this.preTransform,
      this.refit,
      this.step,
      required this.src,
      this.videoOptions,
      required this.viewSize});
}

class Urls {
  String? media;
  String? placeholder;
  String? poster;
  Urls({this.media, this.placeholder, this.poster});
}

class VideoOptions {
  String? videoTransform;
  String? posterTransform;
  VideoOptions({this.videoTransform, this.posterTransform});
}
