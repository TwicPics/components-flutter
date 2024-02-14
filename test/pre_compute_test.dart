
import 'package:flutter_test/flutter_test.dart';
import 'package:twicpics_components/src/pre_compute.dart';
import 'package:twicpics_components/src/types.dart';


void main() {
    group('preComputeVideoOptions', () {
        test( 'should return empty videoOptions', () {
            VideoOptions videoOptions = preComputeVideoOptions(
                duration: null,
                from:null,
                to: null,
                posterFrom: null
            );
            expect( videoOptions.videoTransform, '' );
            expect( videoOptions.posterTransform, '' );
        } );
        test( 'should return posterTransform based on posterFrom', () {
            VideoOptions videoOptions = preComputeVideoOptions(
                duration: null,
                from:null,
                to: null,
                posterFrom: 1
            );
            expect( videoOptions.videoTransform, '' );
            expect( videoOptions.posterTransform, '/from=1' );
        } );
        test( 'should return videoTransform and posterTransform based on from as posterFrom is null', () {
            VideoOptions videoOptions = preComputeVideoOptions(
                duration: null,
                from:2.1,
                to: null,
                posterFrom: null
            );
            expect( videoOptions.videoTransform, '/from=2.1' );
            expect( videoOptions.posterTransform, '/from=2.1' );
        } );
        test( 'should return posterTransform based on from as posterFrom is null and videoTransform based on from and to', () {
            VideoOptions videoOptions = preComputeVideoOptions(
                duration: null,
                from:2.1,
                to: 4.5,
                posterFrom: null
            );
            expect( videoOptions.videoTransform, '/from=2.1/to=4.5' );
            expect( videoOptions.posterTransform, '/from=2.1' );
        } );
        test( 'should return videoTransform based on duration. Should return an empty posterTransform', () {
            VideoOptions videoOptions = preComputeVideoOptions(
                duration: 4,
                from:null,
                to: null,
                posterFrom: null
            );
            expect( videoOptions.videoTransform, '/duration=4' );
            expect( videoOptions.posterTransform, '' );
        } );
        test( 'should return videoTransform based on to and duration. Should return an empty posterTransform', () {
            VideoOptions videoOptions = preComputeVideoOptions(
                duration: 4,
                from:null,
                to: 3,
                posterFrom: null
            );
            expect( videoOptions.videoTransform, '/to=3/duration=4' );
            expect( videoOptions.posterTransform, '' );
        } );
    } );
}
