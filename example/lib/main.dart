import 'package:example/pages/anchorSample.dart';
import 'package:example/pages/basicSample.dart';
import 'package:example/pages/modeSample.dart';
import 'package:example/pages/focusSample.dart';
import 'package:example/pages/positionSample.dart';
import 'package:example/pages/ratioSample.dart';
import 'package:flutter/material.dart';
import 'package:example/pages/gridSample.dart';
import 'package:example/pages/home.dart';
import 'package:example/pages/cardSample.dart';
import 'package:example/pages/scrollSample.dart';
import 'package:example/pages/transformSample.dart';
import 'package:twicpics_components/twicpics_components.dart';


void main() {
    install(
        domain: "https://demo.twic.pics/",
    );
    runApp( MaterialApp(
        initialRoute: '/home',
        routes: {
            '/': ( context ) => const Home(),
            '/anchor': ( context ) => const AnchorSample(),
            '/basic': ( context ) => const BasicSample(),
            '/card': ( context ) => const CardSample(),
            '/focus': ( context ) => const FocusSample(),
            '/grid': ( context ) => const GridSample(),
            '/home': ( context ) => const Home(),
            '/mode': ( context ) => const ModeSample(),
            '/position': ( context ) => const PositionSample(),
            '/ratio': ( context ) => const RatioSample(),
            '/scroll': ( context ) => const ScrollSample(),
            '/transform': ( context ) => const TransformSample(),
        },
    ) );
}

