import 'package:example/widgets/custom_app_bar.dart';
import 'package:example/widgets/custom_floating_button.dart';
import 'package:example/widgets/sample_container.dart';
import 'package:flutter/material.dart';
import 'package:twicpics_components/twicpics_components.dart';

class TransformSample extends StatefulWidget {
  const TransformSample({super.key});
  @override
  State<TransformSample> createState() => _TransformSampleState();
}

class _TransformSampleState extends State<TransformSample> {
  final transforms = ['', 'flip=x', 'flip=y', 'focus=60px50p/crop=25px25p'];
  int indice = 0;
  void changeTransform() {
    setState(() {
      indice = (indice + 1) % transforms.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: const CustomAppBar(title: 'preTransform Sample'),
      body: SampleContainer(
        label: 'preTransform = ${transforms[indice]}',
        child: TwicImg(
          src: 'cat_1x1.jpg',
          mode: TwicMode.contain,
          preTransform: transforms[indice],
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: changeTransform,
        text: 'Change transform',
      ),
    );
  }
}
