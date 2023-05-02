import 'package:example/pages/anchorSample.dart';
import 'package:example/pages/fitSample.dart';
import 'package:example/pages/focusSample.dart';
import 'package:example/pages/ratioSample.dart';
import 'package:flutter/material.dart';
import 'package:example/pages/gridSample.dart';
import 'package:example/pages/home.dart';
import 'package:example/pages/listSample.dart';
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
            '/fit': ( context ) => const FitSample(),
            '/focus': ( context ) => const FocusSample(),
            '/grid': ( context ) => const GridSample(),
            '/home': ( context ) => const Home(),
            '/list': ( context ) => const ListSample(),
            '/ratio': ( context ) => const RatioSample(),
            '/scroll': ( context ) => const ScrollSample(),
            '/transform': ( context ) => const TransformSample(),
        },
    ) );
}

