import 'package:example/widgets/custom_app_bar.dart';
import 'package:example/widgets/sample_container.dart';
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
      backgroundColor: Colors.grey[200],
      appBar: const CustomAppBar(title: 'Basic Sample'),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SampleContainer(
                label: 'Default',
                child: TwicImg(
                  src: 'football.jpg',
                ),
              ),
              SampleContainer(
                label: 'Ratio 16/9',
                child: TwicImg(
                  src: 'football.jpg',
                  ratio: '16/9',
                ),
              ),
              SampleContainer(
                label: 'Ratio 16/9 + contain',
                child: TwicImg(
                  src: 'football.jpg',
                  ratio: '16/9',
                  mode: TwicMode.contain,
                ),
              ),
              SampleContainer(
                label: 'Ratio none',
                child: SizedBox.fromSize(
                  size: const Size(400, 100.5),
                  child: TwicImg(
                    src: "football.jpg",
                    ratio: 'none',
                    mode: TwicMode.cover,
                  ),
                ),
              ),
              SampleContainer(
                label: 'In a row',
                child: Row(
                  children: [
                    Expanded(
                      child: TwicImg(
                        src: "football.jpg",
                        ratio: 1,
                        mode: TwicMode.cover,
                        anchor: TwicPosition.left,
                      ),
                    ),
                    Expanded(
                      child: TwicImg(
                        src: "football.jpg",
                        ratio: 2,
                        mode: TwicMode.contain,
                        position: TwicPosition.right,
                      ),
                    ),
                  ],
                ),
              ),
              SampleContainer(
                label: 'Placeholder maincolor',
                child: TwicImg(
                  src: 'football.jpg',
                  placeholder: TwicPlaceholder.maincolor,
                ),
              ),
              SampleContainer(
                label: 'Placeholder meancolor',
                child: TwicImg(
                  src: 'football.jpg',
                  placeholder: TwicPlaceholder.meancolor,
                ),
              ),
              SampleContainer(
                label: 'Placeholder none',
                child: TwicImg(
                  src: 'football.jpg',
                  placeholder: TwicPlaceholder.none,
                ),
              ),
              SampleContainer(
                label: 'Refit true',
                child: TwicImg(src: 'football.jpg', refit: true),
              ),
              SampleContainer(
                label: 'Refit true + background remove',
                child: TwicImg(
                  src: 'football.jpg',
                  refit: true,
                  preTransform: 'background=remove+rgb(143,0,255,0.1)',
                ),
              ),
              SampleContainer(
                label: 'Colorize alpha red, long transition',
                child: TwicImg(
                  src: 'football.jpg',
                  placeholder: TwicPlaceholder.meancolor,
                  preTransform: 'colorize=red.5',
                  transitionDuration: const Duration(seconds: 10),
                ),
              ),
              SampleContainer(
                label: 'Colorize alpha red, long transition but jpeg',
                child: TwicImg(
                  src: 'football.jpg',
                  placeholder: TwicPlaceholder.meancolor,
                  preTransform: 'colorize=red.5/output=jpeg',
                  transitionDuration: const Duration(seconds: 10),
                ),
              ),
              SampleContainer(
                label: 'inside=200x400/border=green meancolor, long transition',
                child: TwicImg(
                  src: 'cat_1x1.jpg',
                  mode: TwicMode.contain,
                  placeholder: TwicPlaceholder.meancolor,
                  preTransform: 'inside=200x400/border=green',
                  transitionDuration: const Duration(seconds: 10),
                ),
              ),
              SampleContainer(
                label: 'inside=200x400/border=green preview, long transition',
                child: TwicImg(
                  src: 'cat_1x1.jpg',
                  mode: TwicMode.contain,
                  preTransform: 'inside=200x400/border=green',
                  transitionDuration: const Duration(seconds: 10),
                ),
              ),
              SampleContainer(
                label: 'inside=200x400/border=green.5',
                child: TwicImg(
                  src: 'cat_1x1.jpg',
                  mode: TwicMode.contain,
                  placeholder: TwicPlaceholder.meancolor,
                  preTransform: 'inside=200x400/border=green.5',
                ),
              ),
              SampleContainer(
                label: 'inside=500x200/inside=500x500/border=red',
                child: TwicImg(
                  src: 'cat_1x1.jpg',
                  ratio: 1,
                  preTransform: 'inside=500x200/inside=500x500/border=red',
                ),
              ),
              SampleContainer(
                label: 'inside=500x200/inside=500x500/border=red + meancolor',
                child: TwicImg(
                  src: 'football.jpg',
                  ratio: 1,
                  preTransform: 'inside=500x200/inside=500x500/border=red',
                  placeholder: TwicPlaceholder.meancolor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
