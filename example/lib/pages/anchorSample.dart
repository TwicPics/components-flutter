import 'package:flutter/material.dart';
import 'package:twicpics_components/twicpics_components.dart';

class AnchorSample extends StatefulWidget {
    const AnchorSample({super.key});

    @override
    State<AnchorSample> createState() => _AnchorSampleState();
}

class Config {
    Alignment anchor;
    TwicFit fit;
    String ratio;
    String? preTransform;
    Config( {required this.anchor, required this.fit, this.preTransform, required this.ratio });
}

class _AnchorSampleState extends State<AnchorSample> {

    static List< Config > config = [
        Config(anchor: Alignment.center, fit: TwicFit.contain, ratio: '4/3', preTransform: 'focus=bottom-right/cover=1:1' ),
        Config(anchor: Alignment.centerLeft, fit: TwicFit.contain, ratio: '4/3', preTransform: 'focus=bottom-right/cover=1:1' ),
        Config(anchor: Alignment.centerRight, fit: TwicFit.contain, ratio: '4/3', preTransform: 'focus=bottom-right/cover=1:1' ),
        Config(anchor: Alignment.center, fit: TwicFit.contain, ratio: '3/4', preTransform: 'focus=bottom-right/cover=1:1' ),
        Config(anchor: Alignment.topCenter, fit: TwicFit.contain, ratio: '3/4', preTransform: 'focus=bottom-right/cover=1:1' ),
        Config(anchor: Alignment.bottomCenter, fit: TwicFit.contain, ratio: '3/4', preTransform: 'focus=bottom-right/cover=1:1' ),
        Config(anchor: Alignment.center, fit: TwicFit.cover, ratio: '3/4', preTransform: 'focus=bottom-right/cover=1:1' ),
        Config(anchor: Alignment.centerLeft, fit: TwicFit.cover, ratio: '3/4', preTransform: 'focus=bottom-right/cover=1:1' ),
        Config(anchor: Alignment.centerRight, fit: TwicFit.cover, ratio: '3/4', preTransform: 'focus=bottom-right/cover=1:1' ),
        Config(anchor: Alignment.center, fit: TwicFit.cover, ratio: '4/3', preTransform: 'cover=1:1' ),
        Config(anchor: Alignment.topCenter, fit: TwicFit.cover, ratio: '4/3', preTransform: 'cover=1:1' ),
        Config(anchor: Alignment.bottomCenter, fit: TwicFit.cover, ratio: '4/3', preTransform: 'cover=1:1' ),
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
                title: const Text( 'Anchor Sample' ),
                centerTitle: true,
                elevation: 0,
            ),
            body:  Container(
                padding: const EdgeInsets.all(30),
                child: TwicImg(
                    src: 'components/anchor/anchor.jpg',
                    anchor: config[ indice ].anchor,
                    fit: config[ indice ].fit,
                    preTransform: config[ indice ].preTransform,
                    ratio: config[ indice ].ratio,
                ),
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                    changeAnchor();
                },
                label: const Text( 'Change Anchor' ),
                backgroundColor: const Color.fromRGBO( 161, 52, 246, 1 ),
            ),
        );
    }
}