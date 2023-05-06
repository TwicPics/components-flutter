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
                child:GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(8),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    children:[
                        ElevatedButton(
                            onPressed: () { Navigator.pushNamed( context , '/anchor' ); },
                            child: const Text('Anchor'),
                        
                        ),
                        ElevatedButton(
                            onPressed: () { Navigator.pushNamed( context , '/basic' ); },
                            child: const Text('Basic'),
                        ),
                        ElevatedButton(
                            onPressed: () { Navigator.pushNamed( context , '/card' ); },
                            child: const Text('Card'),
                        ),
                        ElevatedButton(
                            onPressed: () { Navigator.pushNamed( context , '/focus' ); },
                            child: const Text('Focus'),
                        ),
                        ElevatedButton(
                            onPressed: () { Navigator.pushNamed( context , '/grid' ); },
                            child: const Text('GridView'),
                        ),
                        ElevatedButton(
                            onPressed: () { Navigator.pushNamed( context , '/hero' ); },
                            child: const Text('Hero'),
                        ),
                        ElevatedButton(
                            onPressed: () { Navigator.pushNamed( context , '/mode' ); },
                            child: const Text('Mode'),
                        ),
                        ElevatedButton(
                            onPressed: () { Navigator.pushNamed( context , '/position' ); },
                            child: const Text('Position'),
                        ),
                        ElevatedButton(
                            onPressed: () { Navigator.pushNamed( context , '/ratio' ); },
                            child: const Text('Ratio'),
                        ),
                        ElevatedButton(
                            onPressed: () { Navigator.pushNamed( context , '/scroll' ); },
                            child: const Text('ScrollView'),
                        ),
                        ElevatedButton(
                            onPressed: () { Navigator.pushNamed( context , '/transform' ); },
                            child: const Text('Transform'),
                        ),
                    ]
                ), 
            ),
        );
    }
}