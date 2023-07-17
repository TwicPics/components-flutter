import 'dart:typed_data';
import 'package:flutter/widgets.dart';

class Attributes {
    Alignment? alignment;
    Alignment? anchor;
    bool eager;
    String? focus;
    Size? intrinsic;
    BoxFit fit;
    TwicPlaceholder placeholder;
    String? preTransform;
    double ratio;
    String? refit;
    String src;
    int? step;
    Duration transitionDuration;
    Attributes( { 
        required this.alignment,
        this.anchor,
        required this.eager,
        this.focus,
        this.intrinsic,
        required this.fit,
        required this.placeholder,
        required this.preTransform,
        required this.ratio,
        this.refit,
        required this.src,
        this.step,
        required this.transitionDuration,
    } );
}

class Config {
    bool cacheCleanOnStartUp = false;
    Duration cacheStalePeriod = const Duration( days: 7);
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
    Context( { required this.mode, required this.size } );
}


class PlaceholderData {
    Uint8List? bytes;
    int? color;
    double? deviation;
    late double height;
    late double width;
    PlaceholderData( { this.bytes, this.color, this.deviation, required this.height, required this.width } );
}

class Size {
    double? height;
    double width;
    Size( { required this.width, this.height } );
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
