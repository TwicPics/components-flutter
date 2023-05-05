import 'package:flutter_test/flutter_test.dart';
import 'package:twicpics_components/src/twic_placeholder.dart';
import 'package:twicpics_components/src/types.dart';
import 'package:twicpics_components/src/utils.dart';

void main() {
    group('getPlaceholderData', () {
        test('should return preview: width, height, deviation and bytes', () async{
            PlaceholderData? placeholderData = await getPlaceholderData(
                url: 'https://demo.twic.pics/cat_1x1.jpg?twic=v1/cover=1000x1000/output=preview',
                viewSize: Size(width: 1000, height: 1000)
            );
            expect( placeholderData, isNot( equals( null ) ) );
            expect( placeholderData!.height, 1000 );
            expect( placeholderData.width, 1000 );
            expect( placeholderData.bytes, isNot( equals( null ) ) );
            expect( isPositiveNumber( placeholderData.deviation ), true );
            expect( placeholderData.color, null );
        });

        test('should return maincolor: width, height, and color', () async{
            PlaceholderData? placeholderData = await getPlaceholderData(
                url: 'https://demo.twic.pics/cat_1x1.jpg?twic=v1/cover=1000x1000/output=maincolor',
                viewSize: Size(width: 1000, height: 1000)
            );
            expect( placeholderData, isNot( equals( null ) ) );
            expect( placeholderData!.height, 1000 );
            expect( placeholderData.width, 1000 );
            expect( placeholderData.bytes, null );
            expect( placeholderData.deviation, null );
            expect( placeholderData.color, 4278386946 );
        });

        test('should return meancolor: width, height, and color', () async{
            PlaceholderData? placeholderData = await getPlaceholderData(
                url: 'https://demo.twic.pics/cat_1x1.jpg?twic=v1/cover=1000x1000/output=meancolor',
                viewSize: Size(width: 1000, height: 1000)
            );
            expect( placeholderData, isNot( equals( null ) ) );
            expect( placeholderData!.height, 1000 );
            expect( placeholderData.width, 1000 );
            expect( placeholderData.bytes, null );
            expect( placeholderData.deviation, null );
            expect( placeholderData.color, 4279702034 );
        });

        test('should return null', () async{
            PlaceholderData? placeholderData = await getPlaceholderData(
                url: 'https://demo.twic.pics/cat_1x1.jpg?twic=v1/cover=1000x1000/output=invalid',
                viewSize: Size(width: 1000, height: 1000)
            );
            expect( placeholderData, null );
        });

        test('should return intrinsic preview dimensions', () async{
            PlaceholderData? placeholderData = await getPlaceholderData(
                url: 'https://demo.twic.pics/cat_1x1.jpg?twic=v1/contain=800x600/output=preview',
                viewSize: Size(width: 800, height: 600)
            );
            expect( placeholderData, isNot( equals( null ) ) );
            expect( placeholderData!.height, 600 );
            expect( placeholderData.width, 600 );
        });

        test('should return intrinsic preview dimensions', () async{
            PlaceholderData? placeholderData = await getPlaceholderData(
                url: 'https://demo.twic.pics/cat_1x1.jpg?twic=v1/contain=600x800/output=preview',
                viewSize: Size(width: 600, height: 800)
            );
            expect( placeholderData, isNot( equals( null ) ) );
            expect( placeholderData!.height, 600 );
            expect( placeholderData.width, 600 );
        });
    } );
}
