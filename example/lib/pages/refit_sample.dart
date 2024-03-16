import 'package:example/widgets/custom_app_bar.dart';
import 'package:example/widgets/custom_floating_button.dart';
import 'package:example/widgets/sample_container.dart';
import 'package:flutter/material.dart';
import 'package:twicpics_components/twicpics_components.dart';

class RefitSample extends StatefulWidget {
  const RefitSample({super.key});
  @override
  State<RefitSample> createState() => _RefitSampleState();
}

class Config {
  TwicMode mode;
  TwicPosition anchor;
  dynamic refit;
  Config(
      {this.mode = TwicMode.cover,
      this.anchor = TwicPosition.center,
      this.refit});
}

class _RefitSampleState extends State<RefitSample> {
  static List<Config> config = [
    Config(mode: TwicMode.cover),
    Config(mode: TwicMode.cover, refit: true),
    Config(mode: TwicMode.cover, refit: '10p'),
    Config(anchor: TwicPosition.left, mode: TwicMode.cover, refit: '5p'),
    Config(anchor: TwicPosition.right, mode: TwicMode.cover, refit: '5p'),
    Config(mode: TwicMode.contain),
    Config(mode: TwicMode.contain, refit: true),
    Config(mode: TwicMode.contain, refit: '10p'),
    Config(anchor: TwicPosition.left, mode: TwicMode.contain, refit: '10p'),
    Config(anchor: TwicPosition.right, mode: TwicMode.contain, refit: '10p'),
  ];
  int indice = 0;
  void changeConfig() {
    setState(() {
      indice = (indice + 1) % config.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: const CustomAppBar(title: 'Refit Sample'),
      body: SampleContainer(
        label:
            'refit = ${config[indice].refit}, mode = ${config[indice].mode}, anchor = ${config[indice].anchor}',
        child: TwicImg(
          anchor: config[indice].anchor,
          src: 'components/refit/dog-looking-water.jpg',
          mode: config[indice].mode,
          refit: config[indice].refit,
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: changeConfig,
        text: 'Change Refit',
      ),
    );
  }
}
