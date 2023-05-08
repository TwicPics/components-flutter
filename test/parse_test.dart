import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twicpics_components/src/install.dart';
import 'package:twicpics_components/src/parse.dart';
import 'package:twicpics_components/src/types.dart';


void main() {

    group('Parse anchor', () {
        test( 'should fallback to the null', () {
            expect( parseAnchor( null ), null );
        } );
        test( 'should parse TwicPosition.bottom to Alignment.bottomCenter', () {
            expect( parseAnchor( TwicPosition.bottom ), Alignment.bottomCenter );
        } );
        test( 'should parse TwicPosition.bottomLeft to Alignment.bottomLeft', () {
            expect( parseAnchor( TwicPosition.bottomLeft ), Alignment.bottomLeft );
        } );
        test( 'should parse TwicPosition.bottomRight to Alignment.bottomRight', () {
            expect( parseAnchor( TwicPosition.bottomRight ), Alignment.bottomRight );
        } );
        test( 'should parse TwicPosition.center to Alignment.botcentertomRight', () {
            expect( parseAnchor( TwicPosition.center ), Alignment.center );
        } );
        test( 'should parse TwicPosition.left to Alignment.centerLeft', () {
            expect( parseAnchor( TwicPosition.left ), Alignment.centerLeft );
        } );
        test( 'should parse TwicPosition.right to Alignment.centerRight', () {
            expect( parseAnchor( TwicPosition.right ), Alignment.centerRight );
        } );
        test( 'should parse TwicPosition.top to Alignment.topCenter', () {
            expect( parseAnchor( TwicPosition.top ), Alignment.topCenter );
        } );
        test( 'should parse TwicPosition.topLeft to Alignment.topLeft', () {
            expect( parseAnchor( TwicPosition.topLeft ), Alignment.topLeft );
        } );test( 'should parse TwicPosition.topRight to Alignment.topRight', () {
            expect( parseAnchor( TwicPosition.topRight ), Alignment.topRight );
        } );
    } );
    group('Parse position', () {
        test( 'should fallback to the null', () {
            expect( parsePosition( null ), null );
        } );
        test( 'should parse TwicPosition.bottom to Alignment.bottomCenter', () {
            expect( parsePosition( TwicPosition.bottom ), Alignment.bottomCenter );
        } );
        test( 'should parse TwicPosition.bottomLeft to Alignment.bottomLeft', () {
            expect( parsePosition( TwicPosition.bottomLeft ), Alignment.bottomLeft );
        } );
        test( 'should parse TwicPosition.bottomRight to Alignment.bottomRight', () {
            expect( parsePosition( TwicPosition.bottomRight ), Alignment.bottomRight );
        } );
        test( 'should parse TwicPosition.center to Alignment.botcentertomRight', () {
            expect( parsePosition( TwicPosition.center ), Alignment.center );
        } );
        test( 'should parse TwicPosition.left to Alignment.centerLeft', () {
            expect( parsePosition( TwicPosition.left ), Alignment.centerLeft );
        } );
        test( 'should parse TwicPosition.right to Alignment.centerRight', () {
            expect( parsePosition( TwicPosition.right ), Alignment.centerRight );
        } );
        test( 'should parse TwicPosition.top to Alignment.topCenter', () {
            expect( parsePosition( TwicPosition.top ), Alignment.topCenter );
        } );
        test( 'should parse TwicPosition.topLeft to Alignment.topLeft', () {
            expect( parsePosition( TwicPosition.topLeft ), Alignment.topLeft );
        } );test( 'should parse TwicPosition.topRight to Alignment.topRight', () {
            expect( parsePosition( TwicPosition.topRight ), Alignment.topRight );
        } );
    } );
    group('Parse eager', () {
        test( 'should fallback to the default value', () {
            expect( parseEager( null ), false );
        } );
        test( 'should set eager to true', () {
            expect( parseEager( true ), true );
        } );
        test( 'should set eager to false', () {
            expect( parseEager( false ), false );
        } );
    } );

    group('Parse focus', () {
        test( 'should fallback to null', () {
            expect( parseFocus( null ), null );
        } );
        test( 'should return "auto"', () {
            expect( parseFocus( 'auto' ), 'auto' );
            expect( parseFocus( ' 50px25p ' ), '50px25p' );
            expect( parseFocus( '50px25p' ), '50px25p' );
            expect( parseFocus( ' 152x467 ' ), '152x467' );
            expect( parseFocus( '152x467' ), '152x467' );
        } );
        test( 'should trim value', () {
            expect( parseFocus( ' auto ' ), 'auto' );
        } );
        test( 'should return a percent focus ', () {
            expect( parseFocus( ' 50px25p ' ), '50px25p' );
        } );
        test( 'should return a coordinates value', () {
            expect( parseFocus( ' 152x467 ' ), '152x467' );
        } );
    } );

    group('Parse fit', () {
        test( 'should fallback to cover', () {
            expect( parseMode( null ), BoxFit.cover );
        } );
        test( 'should parse mode contain', () {
            expect( parseMode( TwicMode.contain ), BoxFit.contain );
        } );
        test( 'should parse mode cover', () {
            expect( parseMode( TwicMode.cover ), BoxFit.cover );
        } );
    } );

    group('Parse intrinsic', () {
        test( 'should fallback to null', () {
            expect( parseIntrinsic( null ), null );
        } );
        test( 'should parse intrinsic into Size', () {
            Size? s = parseIntrinsic(' 800 x 600 ');
            expect( s?.width, 800 );
            expect( s?.height, 600 );
        } );
        test( 'should return null as value is invalid as dimensions are not integer', () {
            Size? s = parseIntrinsic(' 800.5 x 600.5 ');
            expect( s, null );
        } );
        test( 'should return null as value is invalid', () {
            Size? s = parseIntrinsic(' 800 x ');
            expect( s, null );
        } );

    } );

    group('Parse placeholder', () {
        test( 'should fallback to preview', () {
            expect( parsePlaceholder( null ), TwicPlaceholder.preview );
        } );
        test( 'should return preview', () {
            expect( parsePlaceholder( TwicPlaceholder.preview ), TwicPlaceholder.preview );
        } );
        test( 'should return maincolor', () {
            expect( parsePlaceholder( TwicPlaceholder.maincolor ), TwicPlaceholder.maincolor );
        } );
        test( 'should return meancolor', () {
            expect( parsePlaceholder( TwicPlaceholder.meancolor ), TwicPlaceholder.meancolor );
        } );
        test( 'should return none', () {
            expect( parsePlaceholder( TwicPlaceholder.none ), TwicPlaceholder.none );
        } );
    } );

    group('Parse preTransform', () {
        test( 'should fallback to null', () {
            expect( parsePreTransform( null ), null );
        } );
        test( 'should fallback to null', () {
            expect( parsePreTransform( '' ), null );
        } );
        test( 'should add a trailing slash', () {
            expect( parsePreTransform( 'flip=x' ), 'flip=x/' );
            expect( parsePreTransform( 'flip=x/flip=y' ), 'flip=x/flip=y/' );
        } );

        test( 'should trim values', () {
            expect( parsePreTransform( ' flip=x/flip=y/' ), 'flip=x/flip=y/' );
            expect( parsePreTransform( ' flip=x/flip=y/ ' ), 'flip=x/flip=y/' );
        } );
    } );

    group('Parse ratio', () {
        test( 'should fallback to 1', () {
            expect( parseRatio( null ), 1 );
        } );
        test( 'should return 0', () {
            expect( parseRatio( 'none' ), 0 );
        } );
        test( 'should parse ratio = 2', () {
            expect( parseRatio( 2 ), 0.5 );
        } );
        test( 'should parse ratio="2"', () {
            expect( parseRatio( '2' ), 0.5 );
        } );
        test( 'should parse ratio="16/9"', () {
            expect( parseRatio( '16/9' ), 9/16 );
        } );
    } );

    group('Parse src', () {
        test( 'should parse src without path', () {
            install(
                domain: 'https://demo.twic.pics'
            );
            expect( parseSrc( 'media:cat.jpg' ), 'media:cat.jpg' );
            expect( parseSrc( ' cat.jpg ' ), 'media:cat.jpg' );
            expect( parseSrc( 'https://demo.twic.pics/components/cat.jpg' ), 'media:components/cat.jpg' );
        } );

        test( 'should parse src with path', () {
            install(
                domain: 'https://demo.twic.pics',
                path: 'my_path',
            );
            expect( parseSrc( 'media:cat.jpg' ), 'media:my_path/cat.jpg' );
            expect( parseSrc( ' cat.jpg ' ), 'media:my_path/cat.jpg' );
            expect( parseSrc( 'https://demo.twic.pics/components/cat.jpg' ), 'media:components/cat.jpg' );
        } );
    } );

    group('Parse transitionDuration', () {
        test( 'should fallback to 400ms', () {
            expect( parseTransitionDuration( null ), const Duration(milliseconds: 400) );
        } );

        test( 'should parse 200ms', () {
            expect( parseTransitionDuration( const Duration( milliseconds: 200 ) ), const Duration(milliseconds: 200) );
        } );
    } );
}
