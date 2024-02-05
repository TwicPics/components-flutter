import 'package:example/components/custom_app_bar.dart';
import 'package:example/components/custom_floating_button.dart';
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
            appBar: const CustomAppBar(
                title: 'Focus Sample'
            ),
            body:  Container(
                padding: const EdgeInsets.all(30),
                child: TwicImg(
                    src: 'football.jpg',
                    ratio: '3/4',
                    focus: focuses[ indice ],
                ),
            ),
            floatingActionButton: CustomFloatingActionButton(
                onPressed: changeFocus,
                text: 'Change Focus',
            ) 
        );
    }
}