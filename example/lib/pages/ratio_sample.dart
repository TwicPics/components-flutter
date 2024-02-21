import 'package:example/components/custom_app_bar.dart';
import 'package:example/components/custom_floating_button.dart';
import 'package:example/components/sample_container.dart';
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
            appBar: const CustomAppBar(
                title: 'Ratio Sample'
            ),
            body: SampleContainer(
                label: 'ratio = ${ ratios[ indice ] }',
                child: TwicImg(
                    src: 'football.jpg',
                    ratio: ratios[ indice ],
                    mode: TwicMode.cover,
                ),
            ),
            floatingActionButton: CustomFloatingActionButton(
                onPressed: changeRatio,
                text: 'Change Ratio',
            ),
        );
    }
}
