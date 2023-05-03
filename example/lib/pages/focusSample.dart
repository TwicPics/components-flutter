import 'package:flutter/material.dart';
import 'package:twicpics_components/twicpics_components.dart';

class FocusSample extends StatefulWidget {
    const FocusSample({super.key});

    @override
    State<FocusSample> createState() => _FocusSampleState();
}

class _FocusSampleState extends State<FocusSample> {

    final focuses = [ '50px50p', 'auto', 'right' ];
    int indice = 0;
    void changeFocus () {
        setState(() {
            indice = ( indice + 1 ) % focuses.length;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[ 200 ],
            appBar: AppBar(
                backgroundColor: const Color.fromRGBO( 161, 52, 246, 1 ),
                title: const Text( 'Focus Sample' ),
                centerTitle: true,
                elevation: 0,
            ),
            body:  Container(
                padding: const EdgeInsets.all(30),
                child: TwicImg(
                    src: 'football.jpg',
                    ratio: '3/4',
                    focus: focuses[ indice ],
                ),
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                    changeFocus();
                },
                label: const Text( 'Change focus' ),
                backgroundColor: const Color.fromRGBO( 161, 52, 246, 1 ),
            ),
        );
    }
}