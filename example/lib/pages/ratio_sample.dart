import 'package:flutter/material.dart';
import 'package:twicpics_components/twicpics_components.dart';

class RatioSample extends StatefulWidget {
    const RatioSample({super.key});
    @override
    State<RatioSample> createState() => _RatioSampleState();
}

class _RatioSampleState extends State<RatioSample> {
    final ratios = [ '1', '4/3', '16/9', '21/9' ];
    int indice = 0;
    void changeRatio () {
        setState(() {
            indice = ( indice + 1 ) % ratios.length;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[ 200 ],
            appBar: AppBar(
                backgroundColor: const Color.fromRGBO( 161, 52, 246, 1 ),
                title: const Text( 'Ratio Sample' ),
                centerTitle: true,
                elevation: 0,
            ),
            body:  Container(
                padding: const EdgeInsets.all(30),
                child: TwicImg(
                    src: 'football.jpg',
                    ratio: ratios[ indice ],
                    mode: TwicMode.cover,
                ),
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                    changeRatio();
                },
                label: const Text( 'Change Ratio' ),
                backgroundColor: const Color.fromRGBO( 161, 52, 246, 1 ),
            ),
        );
    }
}
