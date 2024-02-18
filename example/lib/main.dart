import 'package:example/pages/anchor_sample.dart';
import 'package:example/pages/basic_sample.dart';
import 'package:example/pages/basic_video_sample.dart';
import 'package:example/pages/hero_sample.dart';
import 'package:example/pages/mode_sample.dart';
import 'package:example/pages/focus_sample.dart';
import 'package:example/pages/mode_video_sample.dart';
import 'package:example/pages/position_sample.dart';
import 'package:example/pages/ratio_sample.dart';
import 'package:example/pages/refit_sample.dart';
import 'package:example/pages/video_slicing_sample.dart';
import 'package:flutter/material.dart';
import 'package:example/pages/grid_sample.dart';
import 'package:example/pages/home.dart';
import 'package:example/pages/card_sample.dart';
import 'package:example/pages/scroll_sample.dart';
import 'package:example/pages/transform_sample.dart';
import 'package:twicpics_components/twicpics_components.dart';


void main() {
    install(
        cacheCleanOnStartUp: true,
        cacheMaxNrOfObjects: 200,
        cacheStalePeriod: const Duration( days: 7 ),
        domain: "https://demo.twic.pics/",
        debug: true,
    );
    runApp( MaterialApp(
        initialRoute: '/home',
        routes: {
            '/': ( context ) => const Home(),
            '/anchor': ( context ) => const AnchorSample(),
            '/basic': ( context ) => const BasicSample(),
            '/basicVideo': ( context ) => const BasicVideoSample(),
            '/card': ( context ) => const CardSample(),
            '/focus': ( context ) => const FocusSample(),
            '/grid': ( context ) => const GridSample(),
            '/home': ( context ) => const Home(),
            '/hero': ( context ) => const HeroSample(),
            '/mode': ( context ) => const ModeSample(),
            '/modeVideo': ( context ) => const ModeVideoSample(),
            '/position': ( context ) => const PositionSample(),
            '/refit': ( context ) => const RefitSample(),
            '/ratio': ( context ) => const RatioSample(),
            '/scroll': ( context ) => const ScrollSample(),
            '/transform': ( context ) => const TransformSample(),
            '/videoSlicing': ( context ) => const VideoSlicing(),
        },
    ) );
}

