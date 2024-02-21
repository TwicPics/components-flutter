import 'package:example/components/custom_app_bar.dart';
import 'package:example/components/custom_floating_button.dart';
import 'package:example/components/sample_container.dart';
import 'package:flutter/material.dart';
import 'package:twicpics_components/twicpics_components.dart';

class ModeVideoSample extends StatefulWidget {
    const ModeVideoSample({super.key});
    @override
    State<ModeVideoSample> createState() => _ModeVideoSampleState();
}

class _ModeVideoSampleState extends State<ModeVideoSample> {
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
                title: 'Mode Video Sample'
            ),
            body: Container(
                padding: const EdgeInsets.all(30),
                child: SampleContainer(
                    label: 'mode = ${ fits[ indice ] }',
                    child: TwicVideo(
                        anchor: TwicPosition.center,
                        src: 'video/skater.mp4',
                        mode: fits[ indice ],
                        ratio: '3/4',
                    ),
                )
            ),
            floatingActionButton: CustomFloatingActionButton(
                onPressed: changeFit,
                text: 'Change Mode',
            ),
        );
    }
}