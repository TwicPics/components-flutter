import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
    final VoidCallback onPressed;
    final String text;
    
    const CustomFloatingActionButton( {
        super.key, 
        required this.onPressed,
        required this.text,
    } );

    @override
    Widget build( BuildContext context ) {
        return FloatingActionButton.extended(
            backgroundColor: const Color.fromRGBO( 161, 52, 246, 1 ),
            label: Text( text ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            onPressed: onPressed,
            foregroundColor: Colors.white,
        );
    }
}