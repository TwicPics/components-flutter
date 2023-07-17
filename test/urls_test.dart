import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twicpics_components/src/install.dart';
import 'package:twicpics_components/src/types.dart';
import 'package:twicpics_components/src/urls.dart';

void main() {

    group('isAbsolute', () {
        test( 'should return true', () {
            install( domain: 'https://demo.twic.pics' );
            expect( isAbsolute( src: 'https://demo.twic.pics/myasset.jpg', domain: 'https://demo.twic.pics' ), true );
        } );
        test( 'should return false', () {
            install( domain: 'https://demo.twic.pics' );
            expect( isAbsolute( src: 'image:myasset.jpg', domain: 'https://demo.twic.pics' ), false );
        } );
    } );

    group('computeTransform', () {
        test( 'should return empty as there is no transform', () {
            expect(
                computeTransform(
                    context: Context( 
                        mode: 'cover',
                        size: Size( width: 200, height: 100 )
                    ),
                    transform: '',
                ),
                ''
            );
        } );
        test( 'should return a cover transformation', () {
            expect(
                computeTransform(
                    context: Context( 
                        mode: 'cover',
                        size: Size( width: 200, height: 100 )
                    ),
                    transform: '/*'
                ),
                '/cover=200x100'
            );
        } );
        test( 'should return a contain transformation', () {
            expect(
                computeTransform(
                    context: Context( 
                        mode: 'contain',
                        size: Size( width: 200, height: 100 )
                    ),
                    transform: '/*'
                ),
                '/contain=200x100'
            );
        } );
        test( 'should return a contain transformation without height', () {
            expect(
                computeTransform(
                    context: Context( 
                        mode: 'contain',
                        size: Size( width: 200 )
                    ),
                    transform: '/*'
                ),
                '/contain=200x-'
            );
        } );
        test( 'should return a cover refit transformation', () {
            expect(
                computeTransform(
                    context: Context( 
                        mode: 'cover',
                        size: Size( width: 200, height: 100 )
                    ),
                    transform: '/refit=WxH(15p)@left'
                ),
                '/refit=200x100(15p)@left'
            );
        } );
    } );

    group('createUrl', () {

        test( 'should create TwicPics api url from path src', () {
            expect (
                createUrl(
                    context: Context( mode: 'cover', size: Size(width: 200, height: 100) ),
                    domain: 'https://demo.twic.pics',
                    src: 'media:cat.jpg'
                    
                ),
                'https://demo.twic.pics/cat.jpg?twic=v1/cover=200x100'
            );
        } );
        test( 'should create TwicPics api url from absolute src', () {
            expect (
                createUrl(
                    context: Context( mode: 'cover', size: Size(width: 200, height: 100) ),
                    domain: 'https://demo.twic.pics',
                    src: 'https://demo.twic.pics/cat.jpg'
                ),
                'https://demo.twic.pics/cat.jpg?twic=v1/cover=200x100'
            );
        } );
        test( 'should create TwicPics api url with transformation', () {
            expect(
                createUrl(
                    context: Context( mode: 'cover', size: Size(width: 200, height: 100) ),
                    domain: 'https://demo.twic.pics',
                    src: 'media:cat.jpg',
                    transform: '/flip=x/*',
                ),
                'https://demo.twic.pics/cat.jpg?twic=v1/flip=x/cover=200x100'
            );
        } );
        test( 'should create TwicPics api url with quality transformation', () {
            expect( 
                createUrl(
                    context: Context( mode: 'cover', size: Size(width: 200, height: 100) ),
                    domain: 'https://demo.twic.pics',
                    src: 'media:cat.jpg',
                    quality: 90
                ),
                'https://demo.twic.pics/cat.jpg?twic=v1/cover=200x100/quality=90.0'
            );
        } );
        test( 'should create TwicPics api url with output transformation', () {
            expect( 
                createUrl(
                    context: Context( mode: 'cover', size: Size(width: 200, height: 100) ),
                    domain: 'https://demo.twic.pics',
                    src: 'media:cat.jpg',
                    output: 'maincolor'
                ), 
                'https://demo.twic.pics/cat.jpg?twic=v1/cover=200x100/output=maincolor'
            );
        } );

        test( 'should create TwicPics api url for special asset', () {
            expect( 
                createUrl(
                    context: Context( mode: 'cover', size: Size(width: 200, height: 100) ),
                    domain: 'https://demo.twic.pics',
                    src: 'placeholder:red',
                ),
                'https://demo.twic.pics/v1/cover=200x100/placeholder:red'
            );
        } );
    } );

    group('finalTransform', () {
        test( 'should return final transform', () {
            expect( finalTransform( fit: BoxFit.cover, refit: null ), '/*'); 
        } );
        test( 'should return final transform as using contain mode with refit', () {
            expect( finalTransform( fit: BoxFit.contain, refit: '15p' ), '/*'); 
        } );
        test( 'should not return final transform as there is a refit option with cover mode', () {
            expect( finalTransform( fit: BoxFit.cover, refit: '15p' ), null); 
        } );
    } );
}
