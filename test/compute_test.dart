
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twicpics_components/src/compute.dart';
import 'package:twicpics_components/src/install.dart';
import 'package:twicpics_components/src/types.dart';
import 'package:twicpics_components/src/utils.dart';

void main() {
    group('computeActualSize', () {
        test( 'should round width down to the nearest 50 pixels', () {
            Size actualSize = computeActualSize(
                lqip: false,
                dpr: 1,
                step: 50,
                viewSize: Size( 
                    width: 252,
                    height: 252,
                )
            );
            expect( actualSize.height, 250 );
            expect( actualSize.width, 250 );
        } );
        test( 'should round width down to the nearest 100 pixels', () {
            Size actualSize = computeActualSize(
                lqip: false,
                dpr: 1,
                step: 100,
                viewSize: Size( 
                    width: 250,
                    height: 250,
                )
            );
            expect( actualSize.height, 200 );
            expect( actualSize.width, 200 );
        } );

        test( 'should take into account the value of the DPR', () {
            Size actualSize = computeActualSize(
                lqip: false,
                dpr: 2,
                step: 100,
                viewSize: Size( 
                    width: 250,
                    height: 250,
                )
            );
            expect( actualSize.height, 400 );
            expect( actualSize.width, 400 );
        } );

        test( 'should compute placeholder size with a square ratio', () {
            Size actualSize = computeActualSize(
                lqip: true,
                dpr: 1,
                step: 100,
                viewSize: Size( 
                    width: 250,
                    height: 250,
                )
            );
            expect( actualSize.height, 1000 );
            expect( actualSize.width, 1000 );
        } );

        test( 'should compute placeholder size with a ratio = "2"', () {
            Size actualSize = computeActualSize(
                lqip: true,
                dpr: 1,
                step: 100,
                viewSize: Size( 
                    width: 250,
                    height: 125,
                )
            );
            expect( actualSize.height, 500 );
            expect( actualSize.width, 1000 );
        } );
    } );

    group('computeAlignment', () {
        test( 'should fallback to Alignment.center', () {
            expect( computeAlignment(), Alignment.center );
        } );
        test( 'should not consider anchor when fit is cover', () {
            expect( computeAlignment( fit: BoxFit.cover, anchor: Alignment.topCenter ), Alignment.center );
        } );
        test( 'should return anchor when fit is contain', () {
            expect( computeAlignment( fit: BoxFit.contain, anchor: Alignment.topCenter ), Alignment.topCenter );
        } );
        test( 'alignment should take precedence over anchor when fit is contain', () {
            expect( computeAlignment( fit: BoxFit.contain, alignment: Alignment.bottomLeft, anchor: Alignment.topCenter ), Alignment.bottomLeft );
        } );
    } );

    group('comptePreTransform', () {
        test( 'should return empty string', () {
            String preTransform = computePreTransform(
                fit: BoxFit.cover
            );
            expect( preTransform, '' );
        } );
        test( 'should return simple preTransform', () {
            String preTransform = computePreTransform(
                fit: BoxFit.cover,
                preTransform: 'flip=x/'
            );
            expect( preTransform, 'flip=x/' );
        } );
        test( 'should return preTransform with defined focus', () {
            String preTransform = computePreTransform(
                fit: BoxFit.cover,
                focus: 'auto',
                preTransform: 'flip=x/'
            );
            expect( preTransform, 'flip=x/focus=auto/' );
        } );
        test( 'should return preTransform with focus according to anchor', () {
            String preTransform = computePreTransform(
                fit: BoxFit.cover,
                anchor: Alignment.center,
                preTransform: 'flip=x/'
            );
            expect( preTransform, 'flip=x/focus=center/' );
        } );
        test( 'focus should take precedence', () {
            String preTransform = computePreTransform(
                fit: BoxFit.cover,
                focus: 'auto',
                anchor: Alignment.center,
                preTransform: 'flip=x/'
            );
            expect( preTransform, 'flip=x/focus=auto/' );
        } );
        test( 'should not take focus or anchor into account', () {
            String preTransform = computePreTransform(
                fit: BoxFit.contain,
                focus: 'auto',
                anchor: Alignment.center,
                preTransform: 'flip=x/'
            );
            expect( preTransform, 'flip=x/' );
        } );
    } );

    group('computeUrl', () {
        install(
            domain: 'https://demo.twic.pics',
        );
        test( 'should compute url with cover transformation', () {
            expect(
                computeUrl(
                    fit: BoxFit.cover,
                    src: 'media:cat.jpg',
                    viewSize: Size( width: 400, height: 300 )
                ),
                'https://demo.twic.pics/cat.jpg?twic=v1/cover=400x300' 
            );
        } );
        test( 'should compute url with cover transformation and manage default step', () {
            expect(
                computeUrl(
                    fit: BoxFit.cover,
                    src: 'media:cat.jpg',
                    viewSize: Size( width: 451, height: 451 )
                ),
                'https://demo.twic.pics/cat.jpg?twic=v1/cover=450x450' 
            );
        } );
        test( 'should compute url with contain transformation', () {
            expect(
                computeUrl(
                    fit: BoxFit.contain,
                    src: 'media:cat.jpg',
                    viewSize: Size( width: 400, height: 300 )
                ),
                'https://demo.twic.pics/cat.jpg?twic=v1/contain=400x300' 
            );
        } );
        test( 'should compute url with dpr 2', () {
            expect(
                computeUrl(
                    fit: BoxFit.contain,
                    src: 'media:cat.jpg',
                    dpr: 2,
                    viewSize: Size( width: 400, height: 300 )
                ),
                'https://demo.twic.pics/cat.jpg?twic=v1/contain=800x600' 
            );
        } );
        test( 'should compute url with step = 100', () {
            expect(
                computeUrl(
                    fit: BoxFit.contain,
                    src: 'media:cat.jpg',
                    step: 100,
                    viewSize: Size( width: 455, height: 355 )
                ),
                'https://demo.twic.pics/cat.jpg?twic=v1/contain=400x312' 
            );
        } );
        test( 'should compute url with step = 100 and dpr2', () {
            expect(
                computeUrl(
                    fit: BoxFit.contain,
                    src: 'media:cat.jpg',
                    step: 100,
                    dpr: 2,
                    viewSize: Size( width: 455, height: 355 )
                ),
                'https://demo.twic.pics/cat.jpg?twic=v1/contain=800x624' 
            );
        } );
        test( 'should compute url with placeholder = preview', () {
            expect(
                computeUrl(
                    fit: BoxFit.contain,
                    src: 'media:cat.jpg',
                    lqip: true,
                    placeholder: TwicPlaceholder.preview,
                    viewSize: Size( width: 400, height: 400 )
                ),
                'https://demo.twic.pics/cat.jpg?twic=v1/contain=1000x1000/output=preview' 
            );
        } );
        test( 'should compute url with placeholder = maincolor', () {
            expect(
                computeUrl(
                    fit: BoxFit.contain,
                    src: 'media:cat.jpg',
                    lqip: true,
                    placeholder: TwicPlaceholder.maincolor,
                    viewSize: Size( width: 400, height: 400 )
                ),
                'https://demo.twic.pics/cat.jpg?twic=v1/contain=1000x1000/output=maincolor' 
            );
        } );
    } );
    group('computeViewSize', () {
        test( 'should compute viewSize with ratio="1"', () {
            Size viewSize = computeViewSize( 
                width: 1000,
                ratio: 1
            );
            expect( viewSize.height, 1000 );
            expect( viewSize.width, 1000 );
        } );

        test( 'should compute viewSize with ratio="2"', () {
            Size  viewSize = computeViewSize( 
                width: 1000,
                ratio: 1/ ( 2 )
            );
            expect( viewSize.height, 500 );
            expect( viewSize.width, 1000 );
        } );

        test( 'ratio should take precedence over height', () {
            Size  viewSize = computeViewSize( 
                width: 1000,
                height: 1000,
                ratio: 1/ ( 2 )
            );
            expect( viewSize.height, 500 );
            expect( viewSize.width, 1000 );
        } );

        test( 'should handle hero asset aka ratio = "none"', () {
            Size viewSize = computeViewSize( 
                width: 800,
                height: 600,
                ratio: 0
            );
            expect( viewSize.height, 600 );
            expect( viewSize.width, 800 );
        } );

        test( 'should throw an exception when unconstrained width', () {
            try {
                computeViewSize( 
                    width: 0,
                    height: 1000,
                    ratio: 1
                );
                throw( 'expected exception but none received' );
            } on ArgumentError catch( e ) {
                expect( e.message, buildErrorMessage( 'unconstrained width' ) );
            }
            try {
                computeViewSize( 
                    width: double.infinity,
                    height: 1000,
                    ratio: 1
                );
                throw( 'expected exception but none received' );
            } on ArgumentError catch( e ) {
                expect( e.message, buildErrorMessage( 'unconstrained width' ) );
            }
        } );

        test( 'should throw an exception when unconstrained height', () {
            try {
                computeViewSize( 
                    width: 1000,
                    height: double.infinity,
                    ratio: 0
                );
                throw( 'expected exception but none received' );
            } on ArgumentError catch( e ) {
                expect( e.message, buildErrorMessage( 'unconstrained height' ) );
            }
            try {
                computeViewSize( 
                    width: 1000,
                    height: 0,
                    ratio: 0
                );
                throw( 'expected exception but none received' );
            } on ArgumentError catch( e ) {
                expect( e.message, buildErrorMessage( 'unconstrained height' ) );
            }
        } );
    } );
}
