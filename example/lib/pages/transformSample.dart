import 'package:flutter/material.dart';
import 'package:twicpics_components/twicpics_components.dart';

class TransformSample extends StatefulWidget {
    const TransformSample({super.key});

    @override
    State<TransformSample> createState() => _TransformSampleState();
}

class _TransformSampleState extends State<TransformSample> {

    final transforms = [ '', 'flip=x', 'flip=y', 'focus=60px50p/crop=25px25p' ];
    int indice = 0;
    void changeTransform () {
        setState(() {
            indice = ( indice + 1 ) % transforms.length;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[ 200 ],
            appBar: AppBar(
                backgroundColor: const Color.fromRGBO( 161, 52, 246, 1 ),
                title: const Text( 'preTransform Sample' ),
                centerTitle: true,
                elevation: 0,
            ),
            body:  Container(
                padding: const EdgeInsets.all(30),
                child: TwicImg(
                    src: 'cat_1x1.jpg',
                    mode: TwicMode.contain,
                    preTransform: transforms[ indice ],
                ),
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                    changeTransform();
                },
                label: const Text( 'Change transform' ),
                backgroundColor: const Color.fromRGBO( 161, 52, 246, 1 ),
            ),
        );
    }
}