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
        required this.src,
        this.step,
        required this.transitionDuration,
    } );
}

enum TwicMode {
    contain,
    cover,
}

enum TwicPlaceholder {
    preview,
    maincolor,
    meancolor,
    none,
}

class Config {
    bool debug = false;
    late String domain;
    String? path;
    int step = 50;
    double maxDpr = 2;
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
