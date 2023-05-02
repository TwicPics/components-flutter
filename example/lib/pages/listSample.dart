import 'package:flutter/material.dart';

class ListSample extends StatefulWidget {
    const ListSample({super.key});

    @override
    State<ListSample> createState() => _ListSampleState();
}

class _ListSampleState extends State<ListSample> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
                backgroundColor: const Color.fromRGBO( 161, 52, 246, 1 ),
                title: const Text( 'List Sample' ),
                centerTitle: true,
                elevation: 0,
            ),
            body: const Text( 'List'),
        );
    }
}