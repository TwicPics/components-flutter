import 'package:example/components/custom_app_bar.dart';
import 'package:example/components/custom_floating_button.dart';
import 'package:example/components/sample_container.dart';
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
            appBar: const CustomAppBar(
                title: 'Mode Sample'
            ),
            body: SampleContainer(
                label: 'mode = ${ fits[ indice ] }',
                child: TwicImg(
                    src: 'cat_1x1.jpg',
                    mode: fits[ indice ],
                    ratio: '4/3',
                ),
            ),
            floatingActionButton: CustomFloatingActionButton(
                onPressed: changeFit,
                text: 'Change Mode',
            ),
        );
    }
}