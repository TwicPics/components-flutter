import 'package:flutter/material.dart';
import 'package:twicpics_components/twicpics_components.dart';

class PositionSample extends StatefulWidget {
    const PositionSample({super.key});

    @override
    State<PositionSample> createState() => _PositionSampleState();
}

class Config {
    TwicPosition position;
    String src;
    Config( {required this.position, required this.src });
}

class _PositionSampleState extends State<PositionSample> {
    static List< Config > config = [
        Config( position: TwicPosition.center, src: 'components/position/forest.jpg'),
        Config( position: TwicPosition.left, src: 'components/position/forest.jpg'),
        Config( position: TwicPosition.right, src: 'components/position/forest.jpg'),
        Config( position: TwicPosition.center, src: 'components/position/horse.jpg'),
        Config( position: TwicPosition.top, src: 'components/position/horse.jpg'),
        Config( position: TwicPosition.bottom, src: 'components/position/horse.jpg'),
    ];

    int indice = 0;
    void changeAnchor () {
        setState(() {
            indice = ( indice + 1 ) % config.length;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[ 200 ],
            appBar: AppBar(
                backgroundColor: const Color.fromRGBO( 161, 52, 246, 1 ),
                title: const Text( 'Position Sample' ),
                centerTitle: true,
                elevation: 0,
            ),
            body:  Container(
                padding: const EdgeInsets.all(30),
                child: TwicImg(
                    src: config[ indice ].src,
                    mode: TwicMode.contain,
                    position: config[ indice ].position,
                ),
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                    changeAnchor();
                },
                label: const Text( 'Change Position' ),
                backgroundColor: const Color.fromRGBO( 161, 52, 246, 1 ),
            ),
        );
    }
}
