import 'package:flutter/material.dart';
import 'package:twicpics_components/twicpics_components.dart';

class FitSample extends StatefulWidget {
    const FitSample({super.key});

    @override
    State<FitSample> createState() => _FitSampleState();
}

class _FitSampleState extends State<FitSample> {

    final fits = [ TwicFit.contain, TwicFit.cover ];
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
                title: const Text( 'Fit Sample' ),
                centerTitle: true,
                elevation: 0,
            ),
            body:  Container(
                padding: const EdgeInsets.all(8),
                child: TwicImg(
                    src: 'cat_1x1.jpg',
                    ratio: '4/3',
                    fit: fits[ indice ],
                ),
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                    changeFit();
                },
                label: const Text( 'Change Fit' ),
                backgroundColor: const Color.fromRGBO( 161, 52, 246, 1 ),
            ),
        );
    }
}