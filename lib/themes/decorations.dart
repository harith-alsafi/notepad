import 'package:flutter/material.dart';

class EntryViewStyles {
  static const kHintTextStyle = TextStyle(
    color: Colors.white54,
    fontFamily: 'OpenSans',
  );

  static const kLabelStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );

  static final kBoxDecorationStyle = BoxDecoration(
    color: const Color(0xFF6CA8F1),
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );

  static const mainBoxStyle = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromARGB(255, 105, 158, 223),
        Color.fromARGB(255, 88, 150, 220),
        Color.fromARGB(255, 64, 125, 201),
        Color.fromARGB(255, 51, 122, 202),
      ],
      stops: [0.1, 0.4, 0.7, 0.9],
    ),
  );
}
