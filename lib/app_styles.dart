import 'package:flutter/material.dart';

class AppStyles{

  static const Color ActionColor = Colors.deepPurple;

  static LinearGradient Gradient(BuildContext context){
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Colors.deepOrangeAccent,
        Theme.of(context).primaryColor,
        Colors.orange.shade100,
        Theme.of(context).colorScheme.secondary,
      ],
    );
  }
}