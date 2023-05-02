import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twicpics_components/src/install.dart';
import 'package:twicpics_components/src/parse.dart';
import 'package:twicpics_components/src/types.dart';


void main() {
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
            expect( parseFit( null ), BoxFit.cover );
        } );
        test( 'should parse mode contain', () {
            expect( parseFit( TwicFit.contain ), BoxFit.contain );
        } );
        test( 'should parse mode cover', () {
            expect( parseFit( TwicFit.cover ), BoxFit.cover );
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
