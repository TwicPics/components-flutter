import 'package:flutter/material.dart';
import 'package:twicpics_components/twicpics_components.dart';

class ModeSample extends StatefulWidget {
    const ModeSample({super.key});

    @override
    State<ModeSample> createState() => _ModeSampleState();
}

class _ModeSampleState extends State<ModeSample> {

    final fits = [ TwicMode.contain, TwicMode.cover ];
    int indice = 0;
    void changeFit () {
        setState(() {
            indice = ( indice + 1 ) % fits.length;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[ 200 ],
            appBar: AppBar(
                backgroundColor: const Color.fromRGBO( 161, 52, 246, 1 ),
                title: const Text( 'Mode Sample' ),
                centerTitle: true,
                elevation: 0,
            ),
            body:  Container(
                padding: const EdgeInsets.all(30),
                child: TwicImg(
                    src: 'cat_1x1.jpg',
                    mode: fits[ indice ],
                    ratio: '4/3',
                ),
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                    changeFit();
                },
                label: const Text( 'Change Mode' ),
                backgroundColor: const Color.fromRGBO( 161, 52, 246, 1 ),
            ),
        );
    }
}