import 'package:flutter/material.dart';
import 'package:twicpics_components/twicpics_components.dart';

class HeroSample extends StatelessWidget {
    const HeroSample({super.key});
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[ 200 ],
            appBar: AppBar(
                backgroundColor: const Color.fromRGBO( 161, 52, 246, 1 ),
                title: const Text( 'Hero Sample' ),
                centerTitle: true,
                elevation: 0,
            ),
            body: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: TwicImg(
                    src: 'cat_1x1.jpg',
                    ratio: 'none',
                ),
            )
        );
    }
}