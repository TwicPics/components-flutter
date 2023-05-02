import 'package:twicpics_components/src/utils.dart';

final RegExp rInvalidPath = RegExp( r'\?|^\/*$' );
final RegExp rValidDomain = RegExp( r'(^https?:\/\/[^/]+)(\/*)$' );
final RegExp rValidIntrinsic = trimRegExpFactory( '\\s*(\\d+)\\s*[x]\\s*(\\d+)\\s*' );
final RegExp rValidPath = RegExp( r'^\/*(.+?)\/*$' );
final RegExp rValidRatio = trimRegExpFactory( '(\\d+(?:\\.\\d+)?)(?:\\s*[\\/:]\\s*(\\d+(?:\\.\\d+)?))?|(none)' );