import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../themes/decorations.dart';

class CustomWidgets {
  static Text titleText(String text, {double font = 30.0}) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'OpenSans',
        fontSize: font,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static ElevatedButton entryButton(String text, {VoidCallback? onTap}) {
    return ElevatedButton(
      style: const ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll(Color.fromARGB(255, 131, 191, 255))),
      onPressed: onTap,
      child: Text(
        text,
        style: const TextStyle(
          color: Color.fromARGB(255, 54, 85, 117),
          letterSpacing: 1.5,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
    );
  }

  static AnnotatedRegion<SystemUiOverlayStyle> entryBackGround(
      BuildContext context,
      {double height = double.infinity,
      double width = double.infinity,
      double horizantalPadding = 60.0,
      double verticalPadding = 120,
      Widget? child}) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: double.infinity,
              decoration: EntryViewStyles.mainBoxStyle,
              child: SizedBox(
                height: height,
                width: width,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: horizantalPadding,
                    vertical: verticalPadding,
                  ),
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
