import 'package:example/components/custom_app_bar.dart';
import 'package:example/components/custom_floating_button.dart';
import 'package:example/components/sample_container.dart';
import 'package:flutter/material.dart';
import 'package:twicpics_components/twicpics_components.dart';

class AnchorSample extends StatefulWidget {
    const AnchorSample({super.key});
    @override
    State<AnchorSample> createState() => _AnchorSampleState();
}

class Config {
    TwicPosition anchor;
    TwicMode fit;
    String ratio;
    String? preTransform;
    Config( {required this.anchor, required this.fit, this.preTransform, required this.ratio });
}

class _AnchorSampleState extends State<AnchorSample> {
    static List< Config > config = [
        Config(anchor: TwicPosition.center, fit: TwicMode.contain, ratio: '4/3', preTransform: 'focus=bottom-right/cover=1:1' ),
        Config(anchor: TwicPosition.left, fit: TwicMode.contain, ratio: '4/3', preTransform: 'focus=bottom-right/cover=1:1' ),
        Config(anchor: TwicPosition.right, fit: TwicMode.contain, ratio: '4/3', preTransform: 'focus=bottom-right/cover=1:1' ),
        Config(anchor: TwicPosition.center, fit: TwicMode.contain, ratio: '3/4', preTransform: 'focus=bottom-right/cover=1:1' ),
        Config(anchor: TwicPosition.top, fit: TwicMode.contain, ratio: '3/4', preTransform: 'focus=bottom-right/cover=1:1' ),
        Config(anchor: TwicPosition.bottom, fit: TwicMode.contain, ratio: '3/4', preTransform: 'focus=bottom-right/cover=1:1' ),
        Config(anchor: TwicPosition.center, fit: TwicMode.cover, ratio: '3/4', preTransform: 'focus=bottom-right/cover=1:1' ),
        Config(anchor: TwicPosition.left, fit: TwicMode.cover, ratio: '3/4', preTransform: 'focus=bottom-right/cover=1:1' ),
        Config(anchor: TwicPosition.right, fit: TwicMode.cover, ratio: '3/4', preTransform: 'focus=bottom-right/cover=1:1' ),
        Config(anchor: TwicPosition.center, fit: TwicMode.cover, ratio: '4/3', preTransform: 'cover=1:1' ),
        Config(anchor: TwicPosition.top, fit: TwicMode.cover, ratio: '4/3', preTransform: 'cover=1:1' ),
        Config(anchor: TwicPosition.bottom, fit: TwicMode.cover, ratio: '4/3', preTransform: 'cover=1:1' ),
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
            appBar: const CustomAppBar(
                title: 'Anchor Sample'
            ),
            body:  SampleContainer(
                child: TwicImg(
                    src: 'components/anchor/anchor.jpg',
                    anchor: config[ indice ].anchor,
                    mode: config[ indice ].fit,
                    preTransform: config[ indice ].preTransform,
                    ratio: config[ indice ].ratio,
                ),
            ),
            floatingActionButton: CustomFloatingActionButton(
                onPressed: changeAnchor,
                text: 'Change Anchor',
            ) 
        );
    }
}