import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twicpics_components/src/install.dart';
import 'package:twicpics_components/src/parse.dart';
import 'package:twicpics_components/src/types.dart';

void main() {
  group('Parse anchor', () {
    test('should fallback to the null', () {
      expect(parseAnchor(null), null);
    });
    test('should parse TwicPosition.bottom to Alignment.bottomCenter', () {
      expect(parseAnchor(TwicPosition.bottom), Alignment.bottomCenter);
    });
    test('should parse TwicPosition.bottomLeft to Alignment.bottomLeft', () {
      expect(parseAnchor(TwicPosition.bottomLeft), Alignment.bottomLeft);
    });
    test('should parse TwicPosition.bottomRight to Alignment.bottomRight', () {
      expect(parseAnchor(TwicPosition.bottomRight), Alignment.bottomRight);
    });
    test('should parse TwicPosition.center to Alignment.botcentertomRight', () {
      expect(parseAnchor(TwicPosition.center), Alignment.center);
    });
    test('should parse TwicPosition.left to Alignment.centerLeft', () {
      expect(parseAnchor(TwicPosition.left), Alignment.centerLeft);
    });
    test('should parse TwicPosition.right to Alignment.centerRight', () {
      expect(parseAnchor(TwicPosition.right), Alignment.centerRight);
    });
    test('should parse TwicPosition.top to Alignment.topCenter', () {
      expect(parseAnchor(TwicPosition.top), Alignment.topCenter);
    });
    test('should parse TwicPosition.topLeft to Alignment.topLeft', () {
      expect(parseAnchor(TwicPosition.topLeft), Alignment.topLeft);
    });
    test('should parse TwicPosition.topRight to Alignment.topRight', () {
      expect(parseAnchor(TwicPosition.topRight), Alignment.topRight);
    });
  });

  group('Parse double', () {
    test('should fallback to 0 when null provided', () {
      expect(parseDouble(null), 0);
    });
    test('should fallback to 0 when NAN provided', () {
      expect(parseDouble('NAN'), 0);
    });
    test('should return double when string double provided', () {
      expect(parseDouble('123.45'), 123.45);
    });
    test('should return double when double provided', () {
      expect(parseDouble(123.45), 123.45);
    });
    test('should return double when int provided', () {
      expect(parseDouble(123), 123.0);
    });
  });

  group('Parse color', () {
    test('should return null if null', () {
      expect(parseColor(null), null);
    });
    test('should return null if bad color', () {
      expect(parseColor("badColor"), null);
    });
    test('should return Color from CSS HEX Colors', () {
      expect(parseColor("#FF0202"), const Color(0xFFFF0202));
    });
    test('should return Color from rgb', () {
      expect(parseColor("rgb(255,2,2)"), const Color(0xFFFF0202));
    });
    test('should return Color from rgba', () {
      expect(parseColor("rgba(255,2,2,1)"), const Color(0xFFFF0202));
    });
    test('should return Color from rgba with alpha', () {
      expect(parseColor("rgba(255,2,2,0.5)"), const Color(0x7FFF0202));
    });
    test('should return Color from rgba with RGB and alpha', () {
      expect(parseColor("rgba(255,128,64,0.5)"), const Color(0x7FFF8040));
    });
  });

  group('Parse duration', () {
    test('should return null if null', () {
      expect(parseDuration(null), null);
    });
    test('should return 1 from string "1"', () {
      expect(parseDuration('1'), 1);
    });
    test('should return 1 from num 1', () {
      expect(parseDuration(1), 1);
    });
    test('should return null from num 0', () {
      expect(parseDuration(0), null);
    });
    test('should return decimal value from num', () {
      expect(parseDuration(1.1), 1.1);
    });
    test('should return decimal value from string', () {
      expect(parseDuration('5.6789'), 5.6789);
    });
  });

  group('Parse position', () {
    test('should fallback to the null', () {
      expect(parsePosition(null), null);
    });
    test('should parse TwicPosition.bottom to Alignment.bottomCenter', () {
      expect(parsePosition(TwicPosition.bottom), Alignment.bottomCenter);
    });
    test('should parse TwicPosition.bottomLeft to Alignment.bottomLeft', () {
      expect(parsePosition(TwicPosition.bottomLeft), Alignment.bottomLeft);
    });
    test('should parse TwicPosition.bottomRight to Alignment.bottomRight', () {
      expect(parsePosition(TwicPosition.bottomRight), Alignment.bottomRight);
    });
    test('should parse TwicPosition.center to Alignment.botcentertomRight', () {
      expect(parsePosition(TwicPosition.center), Alignment.center);
    });
    test('should parse TwicPosition.left to Alignment.centerLeft', () {
      expect(parsePosition(TwicPosition.left), Alignment.centerLeft);
    });
    test('should parse TwicPosition.right to Alignment.centerRight', () {
      expect(parsePosition(TwicPosition.right), Alignment.centerRight);
    });
    test('should parse TwicPosition.top to Alignment.topCenter', () {
      expect(parsePosition(TwicPosition.top), Alignment.topCenter);
    });
    test('should parse TwicPosition.topLeft to Alignment.topLeft', () {
      expect(parsePosition(TwicPosition.topLeft), Alignment.topLeft);
    });
    test('should parse TwicPosition.topRight to Alignment.topRight', () {
      expect(parsePosition(TwicPosition.topRight), Alignment.topRight);
    });
  });
  group('Parse eager', () {
    test('should fallback to the default value', () {
      expect(parseEager(null), false);
    });
    test('should set eager to true', () {
      expect(parseEager(true), true);
    });
    test('should set eager to false', () {
      expect(parseEager(false), false);
    });
  });

  group('Parse focus', () {
    test('should fallback to null', () {
      expect(parseFocus(null), null);
    });
    test('should return "auto"', () {
      expect(parseFocus('auto'), 'auto');
      expect(parseFocus(' 50px25p '), '50px25p');
      expect(parseFocus('50px25p'), '50px25p');
      expect(parseFocus(' 152x467 '), '152x467');
      expect(parseFocus('152x467'), '152x467');
    });
    test('should trim value', () {
      expect(parseFocus(' auto '), 'auto');
    });
    test('should return a percent focus ', () {
      expect(parseFocus(' 50px25p '), '50px25p');
    });
    test('should return a coordinates value', () {
      expect(parseFocus(' 152x467 '), '152x467');
    });
  });

  group('Parse fit', () {
    test('should fallback to cover', () {
      expect(parseMode(null), BoxFit.cover);
    });
    test('should parse mode contain', () {
      expect(parseMode(TwicMode.contain), BoxFit.contain);
    });
    test('should parse mode cover', () {
      expect(parseMode(TwicMode.cover), BoxFit.cover);
    });
  });

  group('Parse from', () {
    test('should return null if null', () {
      expect(parseFrom(null), null);
    });
    test('should return 1 from string "1"', () {
      expect(parseFrom('1'), 1);
    });
    test('should return 1 from num 1', () {
      expect(parseFrom(1), 1);
    });
    test('should return null from num 0', () {
      expect(parseFrom(0), null);
    });
    test('should return decimal value from num', () {
      expect(parseFrom(1.1), 1.1);
    });
    test('should return decimal value from string', () {
      expect(parseFrom('5.6789'), 5.6789);
    });
  });

  group('Parse inspect', () {
    test('should fallback to null', () {
      expect(parseInspect(null), null);
    });
    test('should fallback to null when no output in inspect', () {
      expect(parseInspect('{}'), null);
    });
    final inspectData = parseInspect(jsonEncode({
      "input": {
        "alpha": false,
        "format": "jpeg",
        "height": 1386,
        "width": 2080
      },
      "output": {
        "format": "svg",
        "height": 1000,
        "intrinsiceHeight": 36,
        "intrinsicWidth": 24,
        "padding": {
          "bottom": 278,
          "left": 0,
          "right": 0,
          "top": 278,
          "color": "rgb(255,0,0)"
        },
        "width": 667,
        "color": "#EDEDEC"
      }
    }));
    test('should return height', () {
      expect(inspectData!.height, 1000);
    });
    test('should return width', () {
      expect(inspectData!.width, 667);
    });
    test('should return intrinsicWidth', () {
      expect(inspectData!.intrinsicWidth, 24);
    });
    test('should return color', () {
      expect(inspectData!.color, Color.fromRGBO(237, 237, 236, 1));
    });
    test('should return padding bottom', () {
      expect(inspectData!.padding.bottom, 278);
    });
    test('should return padding top', () {
      expect(inspectData!.padding.top, 278);
    });
    test('should return padding left', () {
      expect(inspectData!.padding.left, 0);
    });
    test('should return padding right', () {
      expect(inspectData!.padding.right, 0);
    });
    test('should return padding color', () {
      expect(inspectData!.padding.color, Color.fromRGBO(255, 0, 0, 1));
    });
  });

  group('Parse intrinsic', () {
    test('should fallback to null', () {
      expect(parseIntrinsic(null), null);
    });
    test('should parse intrinsic into Size', () {
      Size? s = parseIntrinsic(' 800 x 600 ');
      expect(s?.width, 800);
      expect(s?.height, 600);
    });
    test('should return null as value is invalid as dimensions are not integer',
        () {
      Size? s = parseIntrinsic(' 800.5 x 600.5 ');
      expect(s, null);
    });
    test('should return null as value is invalid', () {
      Size? s = parseIntrinsic(' 800 x ');
      expect(s, null);
    });
  });
  group('Parse number', () {
    test('should return null if null', () {
      expect(parseNumber(null), null);
    });
    test('should return 1 from string "1"', () {
      expect(parseNumber('1'), 1);
    });
    test('should return 1 from num 1', () {
      expect(parseNumber(1), 1);
    });
    test('should return null from num 0', () {
      expect(parseNumber(0), null);
    });
    test('should return null from negative num', () {
      expect(parseNumber(-5), null);
    });
    test('should return null from negative string', () {
      expect(parseNumber('-5'), null);
    });
    test('should return decimal value from num', () {
      expect(parseNumber(1.1), 1.1);
    });
    test('should return decimal value from string', () {
      expect(parseNumber('5.6789'), 5.6789);
    });
  });

  group('Parse padding', () {
    test(
        'Should return padding with default values when no values are provided',
        () {
      final result = parsePadding(null);
      expect(result.bottom, equals(0));
      expect(result.left, equals(0));
      expect(result.right, equals(0));
      expect(result.top, equals(0));
      expect(result.color, equals(null));
      expect(result.hasPadding(), equals(false));
    });
    test(
        'Should return padding with default values when no values are provided',
        () {
      final result = parsePadding({});
      expect(result.bottom, equals(0));
      expect(result.left, equals(0));
      expect(result.right, equals(0));
      expect(result.top, equals(0));
      expect(result.color, equals(null));
      expect(result.hasPadding(), equals(false));
    });
    test('Should parse padding values correctly without color', () {
      final result =
          parsePadding({'bottom': 10, 'left': 20, 'right': 30, 'top': 40});
      expect(result.bottom, equals(10));
      expect(result.left, equals(20));
      expect(result.right, equals(30));
      expect(result.top, equals(40));
      expect(result.color, equals(null));
      expect(result.hasPadding(), equals(true));
    });
    test('Should parse padding values correctly and hex color', () {
      final result = parsePadding({
        'bottom': 10,
        'left': 20,
        'right': 30,
        'top': 40,
        'color': '#FF0000' // Example color value
      });
      expect(result.bottom, equals(10));
      expect(result.left, equals(20));
      expect(result.right, equals(30));
      expect(result.top, equals(40));
      expect(result.color, equals(const Color(0xFFFF0000)));
      expect(result.hasPadding(), equals(true));
    });
    test('Should parse padding values correctly and rgb color', () {
      final result = parsePadding({
        'bottom': 10,
        'left': 20,
        'right': 30,
        'top': 40,
        'color': '#rgb(0,0,255)' // Example color value
      });
      expect(result.bottom, equals(10));
      expect(result.left, equals(20));
      expect(result.right, equals(30));
      expect(result.top, equals(40));
      expect(result.color, equals(const Color(0xFF0000FF)));
      expect(result.hasPadding(), equals(true));
    });
    test('Should parse padding values correctly and rgba color', () {
      final result = parsePadding({
        'bottom': 10,
        'left': 20,
        'right': 30,
        'top': 40,
        'color': 'rgba(0,0,255,0.5)' // Example color value
      });
      expect(result.bottom, equals(10));
      expect(result.left, equals(20));
      expect(result.right, equals(30));
      expect(result.top, equals(40));
      expect(result.color, equals(const Color(0x7F0000FF)));
      expect(result.hasPadding(), equals(true));
    });
  });

  group('Parse placeholder', () {
    test('should fallback to preview', () {
      expect(parsePlaceholder(null), TwicPlaceholder.preview);
    });
    test('should return preview', () {
      expect(
          parsePlaceholder(TwicPlaceholder.preview), TwicPlaceholder.preview);
    });
    test('should return maincolor', () {
      expect(parsePlaceholder(TwicPlaceholder.maincolor),
          TwicPlaceholder.maincolor);
    });
    test('should return meancolor', () {
      expect(parsePlaceholder(TwicPlaceholder.meancolor),
          TwicPlaceholder.meancolor);
    });
    test('should return none', () {
      expect(parsePlaceholder(TwicPlaceholder.none), TwicPlaceholder.none);
    });
  });

  group('Parse posterFrom', () {
    test('should return null if null', () {
      expect(parsePosterFrom(null), null);
    });
    test('should return 1 from string "1"', () {
      expect(parsePosterFrom('1'), 1);
    });
    test('should return 1 from num 1', () {
      expect(parsePosterFrom(1), 1);
    });
    test('should return null from num 0', () {
      expect(parsePosterFrom(0), null);
    });
    test('should return null from negative num', () {
      expect(parsePosterFrom(-5), null);
    });
    test('should return null from negative string', () {
      expect(parsePosterFrom('-5'), null);
    });
    test('should return decimal value from num', () {
      expect(parsePosterFrom(1.1), 1.1);
    });
    test('should return decimal value from string', () {
      expect(parsePosterFrom('5.6789'), 5.6789);
    });
  });

  group('Parse preTransform', () {
    test('should fallback to null', () {
      expect(parsePreTransform(null), null);
    });
    test('should fallback to null', () {
      expect(parsePreTransform(''), null);
    });
    test('should remove leading slash ', () {
      expect(parsePreTransform('/flip=x'), 'flip=x');
      expect(parsePreTransform('//flip=x/flip=y'), 'flip=x/flip=y');
    });
    test('should remove trailing slash ', () {
      expect(parsePreTransform('flip=x/'), 'flip=x');
      expect(parsePreTransform('flip=x/flip=y//'), 'flip=x/flip=y');
    });
    test('should remove leading and trailing slash ', () {
      expect(parsePreTransform('/flip=x/'), 'flip=x');
      expect(parsePreTransform('//flip=x/flip=y//'), 'flip=x/flip=y');
    });
    test('should trim values', () {
      expect(parsePreTransform(' flip=x/flip=y'), 'flip=x/flip=y');
      expect(parsePreTransform(' flip=x/flip=y '), 'flip=x/flip=y');
    });
  });

  group('Parse ratio', () {
    test('should fallback to 1', () {
      expect(parseRatio(null), 1);
    });
    test('should return 0', () {
      expect(parseRatio('none'), 0);
    });
    test('should parse ratio = 2', () {
      expect(parseRatio(2), 0.5);
    });
    test('should parse ratio="2"', () {
      expect(parseRatio('2'), 0.5);
    });
    test('should parse ratio="16/9"', () {
      expect(parseRatio('16/9'), 9 / 16);
    });
  });

  group('Parse refit', () {
    test('should parse refit with null', () {
      expect(parseRefit(null), null);
    });

    test('should parse refit false', () {
      expect(parseRefit(false), null);
    });

    test('should parse refit true', () {
      expect(parseRefit(true), '');
    });

    test('should parse refit with padding', () {
      expect(parseRefit('15p'), '15p');
    });

    test('should parse refit with padding and too much spaces', () {
      expect(parseRefit(' 15   p    '), '15p');
    });
  });
  group('Parse src', () {
    test('should parse src without path', () {
      install(domain: 'https://demo.twic.pics');
      expect(parseSrc('media:cat.jpg'), 'media:cat.jpg');
      expect(parseSrc(' cat.jpg '), 'media:cat.jpg');
      expect(parseSrc('https://demo.twic.pics/components/cat.jpg'),
          'media:components/cat.jpg');
      expect(parseSrc('video/skater-standing.mp4'),
          'media:video/skater-standing.mp4');
    });

    test('should parse src with path', () {
      install(
        domain: 'https://demo.twic.pics',
        path: 'my_path',
      );
      expect(parseSrc('media:cat.jpg'), 'media:my_path/cat.jpg');
      expect(parseSrc(' cat.jpg '), 'media:my_path/cat.jpg');
      expect(parseSrc('https://demo.twic.pics/components/cat.jpg'),
          'media:components/cat.jpg');
    });
  });

  group('Parse to', () {
    test('should return null if null', () {
      expect(parseTo(null), null);
    });
    test('should return 1 from string "1"', () {
      expect(parseTo('1'), 1);
    });
    test('should return 1 from num 1', () {
      expect(parseTo(1), 1);
    });
    test('should return null from num 0', () {
      expect(parseTo(0), null);
    });
    test('should return decimal value from num', () {
      expect(parseTo(1.1), 1.1);
    });
    test('should return decimal value from string', () {
      expect(parseTo('5.6789'), 5.6789);
    });
  });

  group('Parse transitionDuration', () {
    test('should fallback to 400ms', () {
      expect(parseTransitionDuration(null), const Duration(milliseconds: 400));
    });

    test('should parse 200ms', () {
      expect(parseTransitionDuration(const Duration(milliseconds: 200)),
          const Duration(milliseconds: 200));
    });
  });
}
