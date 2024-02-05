import 'package:example/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:twicpics_components/twicpics_components.dart';

class ScrollSample extends StatefulWidget {
    const ScrollSample({super.key});

    static List images = [
        {
            "url": 'components/portraits/woman-1.jpg',
            "focus": '50px45p',
        },
        {
            "url": 'components/portraits/man-1.jpg',
            "focus": '50px40p',
        },
        {
            "url": 'components/portraits/woman-2.jpg',
            "focus": '50px30p',
        },
        {
            "url": 'components/portraits/man-2.jpg',
            "focus": '',
        },
        {
            "url": 'components/portraits/woman-3.jpg',
            "focus": '',
        },
        {
            "url": 'components/portraits/man-3.jpg',
            "focus": '',
        },
        {
            "url": 'components/portraits/woman-4.jpg',
            "focus": '',
        },
        {
            "url": 'components/portraits/man-4.jpg',
            "focus": '',
        },
        {
            "url": 'components/portraits/woman-5.jpg',
            "focus": '',
        },
        {
            "url": 'components/portraits/man-5.jpg',
            "focus": '50px0p',
        },
        {
            "url": 'components/portraits/woman-6.jpg',
            "focus": '',
        },
        {
            "url": 'components/portraits/man-6.jpg',
            "focus": '',
        },
        {
            "url": 'components/portraits/woman-7.jpg',
            "focus": '',
        },
        {
            "url": 'components/portraits/man-7.jpg',
            "focus": '',
        },
        {
            "url": 'components/portraits/woman-8.jpg',
            "focus": '',
        },
        {
            "url": 'components/portraits/man-8.jpg',
            "focus": '50px100p',
        },
        {
            "url": 'components/portraits/woman-9.jpg',
            "focus": '50px30p',
        },
        {
            "url": 'components/portraits/man-9.jpg',
            "focus": '50px30p',
        },
        {
            "url": 'components/portraits/woman-10.jpg',
            "focus": '50px55p',
        },
        {
            "url": 'components/portraits/man-10.jpg',
            "focus": '',
        },
        {
            "url": 'components/portraits/woman-11.jpg',
            "focus": '50px40p',
        },
        {
            "url": 'components/portraits/man-11.jpg',
            "focus": '50px35p',
        },
        {
            "url": 'components/portraits/woman-12.jpg',
            "focus": '50px30p',
        },
        {
            "url": 'components/portraits/man-12.jpg',
            "focus": '',
        },
        {
            "url": 'components/portraits/woman-13.jpg',
            "focus": '',
        },
        {
            "url": 'components/portraits/man-13.jpg',
            "focus": '',
        },
        {
            "url": 'components/portraits/woman-14.jpg',
            "focus": '50px40p',
        },
        {
            "url": 'components/portraits/man-14.jpg',
            "focus": '',
        },
        {
            "url": 'components/portraits/woman-15.jpg',
            "focus": '50px30p',
        },
        {
            "url": 'components/portraits/man-15.jpg',
            "focus": '',
        },
        {
            "url": 'components/portraits/woman-16.jpg',
            "focus": '50px55p',
        },
        {
            "url": 'components/portraits/man-16.jpg',
            "focus": '',
        },
        {
            "url": 'components/portraits/woman-17.jpg',
            "focus": '',
        },
        {
            "url": 'components/portraits/man-17.jpg',
            "focus": '50px60p',
        },
        {
            "url": 'components/portraits/woman-18.jpg',
            "focus": '',
        },
        {
            "url": 'components/portraits/man-18.jpg',
            "focus": '50px40p',
        },
        {
            "url": 'components/portraits/woman-19.jpg',
            "focus": '50px60p',
        },
        {
            "url": 'components/portraits/man-19.jpg',
            "focus": '50px20p',
        },
        {
            "url": 'components/portraits/woman-20.jpg',
            "focus": '50px40p',
        },
        {
            "url": 'components/portraits/woman-21.jpg',
            "focus": '50px45p',
        },
        {
            "url": 'components/portraits/woman-22.jpg',
            "focus": '50px55p',
        },
        {
            "url": 'components/portraits/man-22.jpg',
            "focus": '50px35p',
        },
        {
            "url": 'components/portraits/woman-23.jpg',
            "focus": '50px45p',
        },
        {
            "url": 'components/portraits/man-26.jpg',
            "focus": '50px45p',
        },
        {
            "url": 'components/portraits/woman-25.jpg',
            "focus": '50px40p',
        },
        {
            "url": 'components/portraits/man-24.jpg',
            "focus": '50px40p',
        },
        {
            "url": 'components/portraits/woman-26.jpg',
            "focus": '50px40p',
        },
        {
            "url": 'components/portraits/man-25.jpg',
            "focus": '50px40p',
        },
    ];

    @override
    State<ScrollSample> createState() => _ScrollSampleState();
}

class _ScrollSampleState extends State<ScrollSample> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: const CustomAppBar(
                title: 'SingleChildScrollView Sample'
            ),
            body: SingleChildScrollView(
                child: Column(
                        children: ScrollSample.images.map( ( image ) => 
                            Container(
                                padding: const EdgeInsets.all(30),
                                child: TwicImg(
                                    src: image['url'],
                                    focus: image['focus'],
                                    ratio: 2.35
                                ),
                            )
                        ).toList(),
                ),
            ),
        );
    }
}
