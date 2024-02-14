import 'package:example/components/custom_app_bar.dart';
import 'package:example/components/custom_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:twicpics_components/twicpics_components.dart';

class VideoSlicing extends StatefulWidget {
    const VideoSlicing({super.key});
    @override
    State<VideoSlicing> createState() => _VideoSlicingState();
}

class Config {
    num? from;
    num? to;
    num? duration;
    num? posterFrom;
    Config( { this.from, this.to, this.duration, this.posterFrom });
}

class _VideoSlicingState extends State<VideoSlicing> {
    static List< Config > config = [
        Config( ),
        Config( posterFrom: 5 ),
        Config( from: 5.1 ),
        Config( from: 15.4, to: 16.6 ),
        Config( from: 15.4, duration: 1.2 ),
        Config( from: 1, duration: 2 ),
    ];
    int indice = 0;
    void changeConfig () {
        setState(() {
            indice = ( indice + 1 ) % config.length;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[ 200 ],
            appBar: const CustomAppBar(
                title: 'Video Slicing Sample'
            ),
            body:  Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                    children: [
                        TwicVideo(
                            src: 'components/refit/dog-looking-water.jpg',
                            from: config[ indice ].from,
                            to: config[ indice ].to,
                            duration: config[ indice ].duration,
                            posterFrom: config[ indice ].posterFrom,
                        ),
                        Text( 'From: ${ config[ indice ].from }' ),
                        Text( 'To: ${ config[ indice ].to }' ),
                        Text( 'Duration: ${ config[ indice ].duration }' ),
                        Text( 'PosterFrom: ${ config[ indice ].posterFrom }' ),
                    ]
                ),
            ),
            floatingActionButton: CustomFloatingActionButton(
                onPressed: changeConfig,
                text: 'Change Slicing',
            ),
        );
    }
}
