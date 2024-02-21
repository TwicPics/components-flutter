import 'package:flutter/material.dart';

class SampleContainer extends StatelessWidget {
    final Widget child;
    final String? label;

    const SampleContainer( { super.key, required this.child, this.label } );
    
    @override
    Widget build(BuildContext context) {
        return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
                children: [
                    Container(
                        child: child,
                    ),
                    label != null ? 
                        Text(
                            label!,
                            style: const TextStyle(fontStyle: FontStyle.italic),
                        ):
                        Container(),
                ]
            )
        );
    }
}