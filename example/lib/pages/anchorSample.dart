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
    Config( {required this.anchor, required this.fit, required this.ratio });
}

class _AnchorSampleState extends State<AnchorSample> {

    static List< Config > config = [
        Config(anchor: Alignment.topCenter, fit: TwicFit.contain, ratio: '3/4'),
        Config(anchor: Alignment.centerRight, fit: TwicFit.contain, ratio: '3/4'),
        Config(anchor: Alignment.bottomCenter, fit: TwicFit.contain, ratio: '3/4'),
        Config(anchor: Alignment.centerLeft, fit: TwicFit.contain, ratio: '3/4'),
        Config(anchor: Alignment.topCenter, fit: TwicFit.cover, ratio: '16/9'),
        Config(anchor: Alignment.bottomCenter, fit: TwicFit.cover, ratio: '16/9'),
        Config(anchor: Alignment.centerLeft, fit: TwicFit.cover, ratio: '9/16'),
        Config(anchor: Alignment.centerRight, fit: TwicFit.cover, ratio: '9/16'),
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
                padding: const EdgeInsets.all(8),
                child: TwicImg(
                    src: 'cat_1x1.jpg',
                    anchor: config[ indice ].anchor,
                    ratio: config[ indice ].ratio,
                    fit: config[ indice ].fit,
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