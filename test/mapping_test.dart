
import 'package:flutter/widgets.dart' hide Placeholder;
import 'package:flutter_test/flutter_test.dart';
import 'package:twicpics_components/src/mapping.dart';
import 'package:twicpics_components/src/types.dart';

void main() {
    
    test( 'should map alignment', () {
        expect( mappingAlignment[ Alignment.bottomCenter ], 'bottom' );
        expect( mappingAlignment[ Alignment.bottomLeft ], 'bottom-left' );
        expect( mappingAlignment[ Alignment.bottomRight ], 'bottom-right' );
        expect( mappingAlignment[ Alignment.center ], 'center' );
        expect( mappingAlignment[ Alignment.centerLeft ], 'left' );
        expect( mappingAlignment[ Alignment.centerRight ], 'right' );
        expect( mappingAlignment[ Alignment.topCenter ], 'top' );
        expect( mappingAlignment[ Alignment.topLeft ], 'top-left' );
        expect( mappingAlignment[ Alignment.topRight ], 'top-right' );
    } );


    test( 'should map placeholders', () {
        expect( mappingPlaceholder[ TwicPlaceholder.maincolor], 'maincolor' );
        expect( mappingPlaceholder[ TwicPlaceholder.meancolor], 'meancolor' );
        expect( mappingPlaceholder[ TwicPlaceholder.none], '' );
        expect( mappingPlaceholder[ TwicPlaceholder.preview], 'preview' );
    } );

}
