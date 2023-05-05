import 'package:flutter/material.dart';
import 'package:twicpics_components/twicpics_components.dart';

class BasicSample extends StatefulWidget {
    const BasicSample({super.key});

    @override
    State<BasicSample> createState() => _BasicSampleState();
}

class _BasicSampleState extends State<BasicSample> {


    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[ 200 ],
            appBar: AppBar(
                backgroundColor: const Color.fromRGBO( 161, 52, 246, 1 ),
                title: const Text( 'Basic Sample' ),
                centerTitle: true,
                elevation: 0,
            ),
            body:  Container(
                padding: const EdgeInsets.all(30),
                child: SingleChildScrollView(
                    child: Column(
                        children: [
                            SizedBox.fromSize(
                                size: const Size(400, 100.5),
                                child: TwicImg(
                                    src: "media:cat_1x1.jpg",
                                    ratio: 1,
                                    mode: TwicMode.cover,
                                ),
                            ),
                            TwicImg(
                                src:"media:cat_1x1.jpg",
                                ratio: 0.5,
                                mode: TwicMode.contain,
                            ),
                            TwicImg(
                                src:"media:cat.jpg",
                                ratio: 1.85,
                                mode: TwicMode.cover,
                            ),
                            Row(
                                children: [
                                Expanded(
                                child: TwicImg(
                                    src:"media:cat_1x1.jpg",
                                    ratio: 2,
                                    mode: TwicMode.cover),
                                ),
                                Expanded(
                                    child: TwicImg(
                                    src:"media:cat.jpg",
                                    ratio: 2,
                                    mode: TwicMode.contain,
                                    ),
                                ),
                                ],
                            ),
                            TwicImg(
                                src: "media:football.jpg",
                                ratio: 2,
                                mode: TwicMode.cover,
                            ),
                            TwicImg(
                                src: "media:football.jpg",
                                ratio: 2,
                                mode: TwicMode.contain,
                            ),
                            TwicImg(
                                src: "media:components/flip/orange-2.jpg",
                                ratio: 1.33,
                                mode: TwicMode.cover,
                            ),
                            TwicImg(
                                src: "media:components/flip/cherry-1.jpg",
                                ratio: 1.65,
                                mode: TwicMode.cover,
                            ),
                            TwicImg(
                                src: "media:components/flip/cherry-2.jpg",
                                ratio: 1.98,
                                mode: TwicMode.cover,
                            ),
                            TwicImg(
                                src: "media:components/flip/fig-2.jpg",
                                ratio: 1.99,
                                mode: TwicMode.cover,
                            ),TwicImg(
                                src: "media:components/flip/orange-1.jpg",
                                ratio: 1.85,
                                mode: TwicMode.cover,
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}