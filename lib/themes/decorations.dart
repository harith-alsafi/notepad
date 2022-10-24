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
        Color(0xFF73AEF5),
        Color(0xFF61A4F1),
        Color(0xFF478DE0),
        Color(0xFF398AE5),
      ],
      stops: [0.1, 0.4, 0.7, 0.9],
    ),
  );
}
