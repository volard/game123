import 'package:flutter/material.dart';

Card numberCard(int number, {ShapeBorder? shapeBorder}) => Card(
    shape: shapeBorder,
    margin: const EdgeInsets.symmetric(horizontal: 5.0),
    child: SizedBox(
      width: 50,
      height: 50,
      child: Center(
        child: Text(
          '$number',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    )
);
