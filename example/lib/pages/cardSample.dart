import 'package:flutter/material.dart';
import 'package:twicpics_components/twicpics_components.dart';

class CardSample extends StatefulWidget {
    const CardSample({super.key});

    @override
    State<CardSample> createState() => _CardSampleState();
}

class _CardSampleState extends State<CardSample> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
                backgroundColor: const Color.fromRGBO( 161, 52, 246, 1 ),
                title: const Text( 'Card Sample' ),
                centerTitle: true,
                elevation: 0,
            ),
            body: Card(
                margin: const EdgeInsets.all(20),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                        ListTile(
                            leading: ClipOval(
                                child: SizedBox(
                                    width: 50,
                                    child: TwicImg(
                                        src: 'components/portraits/woman-14.jpg',
                                        placeholder: TwicPlaceholder.meancolor
                                    ),
                                ),
                            ),
                            title: const Text('a woman hiding her eyes with orange slices'),
                            subtitle: const Text('This is a simple card in Flutter.'),
                        ),
                        ListTile(
                            leading: ClipOval(
                                child: SizedBox(
                                    width: 50,
                                    child: TwicImg(
                                        src: 'components/portraits/woman-1.jpg',
                                        placeholder: TwicPlaceholder.meancolor
                                    ),
                                ),
                            ),
                            title: const Text('a woman'),
                            subtitle: const Text('This is a simple card in Flutter.'),
                        ),
                        ListTile(
                            leading: ClipOval(
                                child: SizedBox(
                                    width: 50,
                                    child: TwicImg(
                                        src: 'cat_1x1.jpg',
                                        placeholder: TwicPlaceholder.meancolor
                                    ),
                                ),
                            ),
                            title: const Text('a cat'),
                            subtitle: const Text('This is a simple card in Flutter.'),
                        ),
                        ListTile(
                            leading: ClipOval(
                                child: SizedBox(
                                    width: 50,
                                    child: TwicImg(
                                        src: 'cat_1x1.jpg',
                                        preTransform: 'flip=x',
                                        placeholder: TwicPlaceholder.meancolor
                                    ),
                                ),
                            ),
                            title: const Text('cat looking in a mirror'),
                            subtitle: const Text('This is a simple card in Flutter.'),
                        ),
                        ListTile(
                            leading: ClipOval(
                                child: SizedBox(
                                    width: 50,
                                    child: TwicImg(
                                        src: 'cat_1x1.jpg',
                                        preTransform: 'flip=x',
                                        placeholder: TwicPlaceholder.meancolor
                                    ),
                                ),
                            ),
                            title: const Text('same cat looking in a mirror'),
                            subtitle: const Text('This is a simple card in Flutter.'),
                        ),
                    ],
                ),
            ),
        );
    }
}