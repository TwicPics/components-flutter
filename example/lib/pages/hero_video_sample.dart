import 'package:example/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:twicpics_components/twicpics_components.dart';

class HeroVideoSample extends StatelessWidget {
    const HeroVideoSample({super.key});
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[ 200 ],
            appBar: const CustomAppBar(
                title: 'Hero Sample'
            ),
            body: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: TwicVideo(
                    src: 'video/skater.mp4',
                    ratio: 'none',
                ),
            )
        );
    }
}