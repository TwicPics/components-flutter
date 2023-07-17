import 'package:flutter/material.dart';

class Home extends StatelessWidget {
    const Home({super.key});
    static List samples = [
        {
            "route": '/anchor',
            "text": 'Anchor',
        },
        {
            "route": '/basic',
            "text": 'Basic',
        },
        {
            "route": '/card',
            "text": 'Cards',
        },
        {
            "route": '/focus',
            "text": 'Focus',
        },
        {
            "route": '/grid',
            "text": 'GridView',
        },
        {
            "route": '/hero',
            "text": 'Hero Image',
        },
        {
            "route": '/mode',
            "text": 'Mode',
        },
        {
            "route": '/position',
            "text": 'Position',
        },
        {
            "route": '/ratio',
            "text": 'Ratio',
        }, {
            "route": '/refit',
            "text": 'Refit',
        },
        {
            "route": '/scroll',
            "text": 'ScrollView',
        },
        {
            "route": '/transform',
            "text": 'PreTransform',
        },
    ];

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
                backgroundColor: const Color.fromRGBO( 161, 52, 246, 1 ),
                title: const Text( 'TwicPics x Flutter' ),
                centerTitle: true,
                elevation: 0,
            ),
            body: Center(
                child:GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(8),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    children:Home.samples.map( ( sample ) => 
                        ElevatedButton(
                            onPressed: () { Navigator.pushNamed( context , sample['route'] ); },
                            child: Text( sample[ 'text' ] ),
                        ),
                    ).toList(),
                ), 
            ),
        );
    }
}