import 'package:flutter/material.dart';
import 'package:twicpics_components/twicpics_components.dart';

class RefitSample extends StatefulWidget {
    const RefitSample({super.key});
    @override
    State<RefitSample> createState() => _RefitSampleState();
}

class _RefitSampleState extends State<RefitSample> {
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
                title: const Text( 'Refit Sample' ),
                centerTitle: true,
                elevation: 0,
            ),
            body:  Container(
                padding: const EdgeInsets.all(30),
                child: TwicImg(
                    src: 'refit/woman-in-canyon.jpeg',
                    ratio: ratios[ indice ],
                    refit: "15p",
                    mode: TwicMode.cover,
                ),
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                    changeRatio();
                },
                label: const Text( 'Change Refit' ),
                backgroundColor: const Color.fromRGBO( 161, 52, 246, 1 ),
            ),
        );
    }
}
