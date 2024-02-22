import 'package:example/widgets/custom_app_bar.dart';
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
      "route": '/basicVideo',
      "text": 'Basic Video',
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
      "route": '/heroVideo',
      "text": 'Hero Video',
    },
    {
      "route": '/mode',
      "text": 'Mode',
    },
    {
      "route": '/modeVideo',
      "text": 'Mode Video',
    },
    {
      "route": '/position',
      "text": 'Position',
    },
    {
      "route": '/ratio',
      "text": 'Ratio',
    },
    {
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
    {
      "route": '/videoSlicing',
      "text": 'Video Slicing',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: const CustomAppBar(title: 'TwicPics x Flutter'),
      body: Center(
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(8),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: Home.samples
              .map((sample) => TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, sample['route']);
                    },
                    child: Text(sample['text']),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
