import 'package:flutter/material.dart';

class Home extends StatefulWidget {
    const Home({super.key});

    @override
    State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                        ElevatedButton(
                            onPressed: () { Navigator.pushNamed( context , '/anchor' ); },
                            child: const Text('Anchor'),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () { Navigator.pushNamed( context , '/basic' ); },
                            child: const Text('Basic'),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () { Navigator.pushNamed( context , '/card' ); },
                            child: const Text('Card'),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () { Navigator.pushNamed( context , '/focus' ); },
                            child: const Text('Focus'),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () { Navigator.pushNamed( context , '/grid' ); },
                            child: const Text('GridView'),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () { Navigator.pushNamed( context , '/mode' ); },
                            child: const Text('Mode'),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () { Navigator.pushNamed( context , '/ratio' ); },
                            child: const Text('Ratio'),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () { Navigator.pushNamed( context , '/scroll' ); },
                            child: const Text('SingleChildScrollView'),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () { Navigator.pushNamed( context , '/transform' ); },
                            child: const Text('Transform'),
                        ),
                    ],
                ),
            ),
        );
    }
}