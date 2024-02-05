import 'package:example/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:twicpics_components/twicpics_components.dart';

class HeroSample extends StatelessWidget {
    const HeroSample({super.key});
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[ 200 ],
            appBar: const CustomAppBar(
                title: 'Hero Sample'
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