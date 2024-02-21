import 'package:example/components/custom_app_bar.dart';
import 'package:example/components/sample_container.dart';
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
            body: Container(
                padding: const EdgeInsets.all(30),
                child: SingleChildScrollView(
                    child: Column(
                        children: [
                            SampleContainer(
                                label: 'Default',
                                child: TwicVideo(
                                    src: 'video/skater.mp4',
                                ),
                            ),
                            SampleContainer(
                                label: 'Contain',
                                child: TwicVideo(
                                    src: 'video/skater.mp4',
                                    mode: TwicMode.contain,
                                ),
                            ),
                            SampleContainer(
                                label: 'Contain + anchor bottom',
                                child: TwicVideo(
                                    anchor: TwicPosition.bottom,
                                    src: 'video/skater.mp4',
                                    mode: TwicMode.contain,
                                ),
                            ),
                            SampleContainer(
                                label: 'Ratio 3/4',
                                child: TwicVideo(
                                    src: 'video/skater.mp4',
                                    ratio: '3/4',
                                ),
                            ),
                            SampleContainer(
                                label: 'Contain + Ratio 3/4',
                                child: TwicVideo(
                                    src: 'video/skater.mp4',
                                    mode: TwicMode.contain,
                                    ratio: '3/4',
                                ),
                            ),
                            SampleContainer(
                                label: 'From 5.1',
                                child: TwicVideo(
                                    src: 'video/skater.mp4',
                                    from: 5.1
                                ),
                            ),
                            SampleContainer(
                                label: 'From 15.4 + to 16.6',
                                child: TwicVideo(
                                    src: 'video/skater.mp4',
                                    from: 15.4,
                                    to: 16.6,
                                ),
                            ),
                            SampleContainer(
                                label: 'Duration 2',
                                child: TwicVideo(
                                    src: 'video/skater.mp4',
                                    duration: 2,
                                    from: 3,
                                ),
                            ),
                            SampleContainer(
                                label: 'Ratio none',
                                child: SizedBox.fromSize(
                                    size: const Size(400, 200),
                                    child: TwicVideo(
                                        src: "video/skater.mp4",
                                        ratio: 'none',
                                        mode: TwicMode.cover,
                                    ),
                                ),
                            ),
                            SampleContainer(
                                label: 'In a row',
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
                                                ratio: 1,
                                                mode: TwicMode.contain,
                                                position: TwicPosition.bottom,
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                            SampleContainer(
                                label: 'Placeholder maincolor',
                                child: TwicVideo(
                                    src: 'video/skater.mp4',
                                    placeholder: TwicPlaceholder.maincolor,
                                ),
                            ),
                            SampleContainer(
                                label: 'Placeholder meancolor',
                                child: TwicVideo(
                                    src: 'video/skater.mp4',
                                    placeholder: TwicPlaceholder.meancolor,
                                ),
                            ),
                            SampleContainer(
                                label: 'Placeholder none',
                                child: TwicVideo(
                                    src: 'video/skater.mp4',
                                    placeholder: TwicPlaceholder.none,
                                ),
                            ),
                            SampleContainer(
                                label: 'Cover',
                                child: TwicVideo(
                                    src: 'video/purple-shirt.mp4',
                                    mode: TwicMode.cover
                                ),
                            ),
                            SampleContainer(
                                label: 'Contain',
                                child: TwicVideo(
                                    src: 'video/purple-shirt.mp4',
                                    mode: TwicMode.contain
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}