import 'package:flutter/material.dart';
import 'package:twicpics_components/twicpics_components.dart';

class HeroSample extends StatefulWidget {
    const HeroSample({super.key});
    @override
    State<HeroSample> createState() => _HeroSampleState();
}

class _HeroSampleState extends State<HeroSample> {
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
                title: const Text( 'Hero Sample' ),
                centerTitle: true,
                elevation: 0,
            ),
            body: Container(
                width: double.infinity,
                height: double.infinity,
                child: TwicImg(
                    src: 'cat_1x1.jpg',
                    ratio: 'none',
                ),
            )
        );
    }
}