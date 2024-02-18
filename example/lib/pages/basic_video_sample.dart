import 'package:example/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:twicpics_components/twicpics_components.dart';

class BasicVideoSample extends StatefulWidget {
    const BasicVideoSample({super.key});
    @override
    State<BasicVideoSample> createState() => _BasicVideoSampleState();
}

class _BasicVideoSampleState extends State<BasicVideoSample> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[ 200 ],
            appBar: const CustomAppBar(
                title: 'Basic Sample'
            ),
            body:  Container(
                padding: const EdgeInsets.all(30),
                child: SingleChildScrollView(
                    child: Column(
                        children: [
                            Container(
                                padding: const EdgeInsets.all(30),
                                child: TwicVideo(
                                    src: 'video/skater.mp4',
                                ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(30),
                                child: TwicVideo(
                                    src: 'video/skater.mp4',
                                    ratio: '16/9',
                                ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(30),
                                child: TwicVideo(
                                    src: 'video/skater.mp4',
                                    ratio: '16/9',
                                    mode: TwicMode.contain,
                                ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(30),
                                child: SizedBox.fromSize(
                                    size: const Size(400, 100.5),
                                    child: TwicVideo(
                                        src: "video/skater.mp4",
                                        ratio: 'none',
                                        mode: TwicMode.cover,
                                    ),
                                ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(30),
                                child: Row(
                                    children: [
                                        Expanded(
                                            child: TwicVideo(
                                                src:"video/skater.mp4",
                                                ratio: 1,
                                                mode: TwicMode.cover,
                                                anchor: TwicPosition.left,
                                            ),
                                        ),
                                        Expanded(
                                            child: TwicVideo(
                                                src:"video/skater.mp4",
                                                ratio: 2,
                                                mode: TwicMode.contain,
                                                position: TwicPosition.right,
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(30),
                                child: TwicVideo(
                                    src: 'video/skater.mp4',
                                    placeholder: TwicPlaceholder.maincolor,
                                ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(30),
                                child: TwicVideo(
                                    src: 'video/skater.mp4',
                                    placeholder: TwicPlaceholder.meancolor,
                                ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(30),
                                child: TwicVideo(
                                    src: 'video/skater.mp4',
                                    placeholder: TwicPlaceholder.none,
                                ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(30),
                                child: TwicVideo(
                                    src: 'video/skater.mp4',
                                    preTransform: 'refit=1:1',
                                ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(30),
                                child: TwicVideo(
                                    src: 'video/skater.mp4',
                                    preTransform: 'refit=1:1/background=remove+rgb(143,0,255,0.1)',
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}