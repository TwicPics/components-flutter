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
                            Container(
                                padding: const EdgeInsets.all(30),
                                child: TwicImg(
                                    src: 'football.jpg',
                                ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(30),
                                child: TwicImg(
                                    src: 'football.jpg',
                                    ratio: '16/9',
                                ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(30),
                                child: TwicImg(
                                    src: 'football.jpg',
                                    ratio: '16/9',
                                    mode: TwicMode.contain,
                                ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(30),
                                child: SizedBox.fromSize(
                                    size: const Size(400, 100.5),
                                    child: TwicImg(
                                        src: "football.jpg",
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
                                            child: TwicImg(
                                                src:"football.jpg",
                                                ratio: 1,
                                                mode: TwicMode.cover,
                                                anchor: TwicPosition.left,
                                            ),
                                        ),
                                        Expanded(
                                            child: TwicImg(
                                                src:"football.jpg",
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
                                child: TwicImg(
                                    src: 'football.jpg',
                                    placeholder: TwicPlaceholder.maincolor,
                                ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(30),
                                child: TwicImg(
                                    src: 'football.jpg',
                                    placeholder: TwicPlaceholder.meancolor,
                                ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(30),
                                child: TwicImg(
                                    src: 'football.jpg',
                                    placeholder: TwicPlaceholder.none,
                                ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(30),
                                child: TwicImg(
                                    src: 'football.jpg',
                                    preTransform: 'refit=1:1',
                                ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(30),
                                child: TwicImg(
                                    src: 'football.jpg',
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